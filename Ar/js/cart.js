// ======= CART SYSTEM =======
let cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];
const totalItems = cartItems.reduce((sum, item) => sum + (item.amount || 0), 0);
const cartItemsNumber = document.querySelector("#cartItemsNumber");
if (totalItems > 0) {
    cartItemsNumber.textContent = totalItems;
    cartItemsNumber.style.display = "inline"; // or "block", depending on your layout
} else {
    cartItemsNumber.style.display = "none";
}
// ✅ Global Cart System — Runs on All Pages

document.addEventListener("DOMContentLoaded", () => {



    const cart = {
        items: JSON.parse(localStorage.getItem("cartItems")) || [],
        deliveryFee:
    parseFloat(document.querySelector("#deliveryFee")?.textContent.trim()) ||
      parseFloat(localStorage.getItem("GLOBAL_DELIVERY_FEE")) || 0,
        save() {
            localStorage.setItem("cartItems", JSON.stringify(this.items));
            this.saveSummary();
            updateCartUI();
            updateCartCounter();
            updateTotalPayAmount();
            const checkoutCart = document.querySelector("#checkoutCart");
            if (checkoutCart) {
                renderCheckoutArticles(this.items, JSON.parse(localStorage.getItem("cartSummary")) || {});
            }

        },


        saveSummary() {
            const rawSubtotal = this.getSubtotal(); // raw sum of all items
            const delivery = this.deliveryFee || 0;

            // =====================================
            // 💥 DELIVERY DISCOUNT LOGIC
            // =====================================
            let totalDeliveryCost = 0; // سنستخدم هذا لتخزين إجمالي رسوم التوصيل قبل الخصم
            let discountAmount = 0;
            let discountedDelivery = 0; // هذا هو إجمالي رسوم التوصيل بعد الخصم

            // نسبة الخصم (تحويل النسبة المئوية إلى كسر عشري)
            const DISCOUNT_RATE = GLOBAL_AREA_DISCOUNT / 100; 
            
            // 1. تجميع رسوم التوصيل حسب ShopAreaId
            // افتراض: item.deliveryFee هو رسوم التوصيل الخاصة بالمتجر
            const areaFees = this.items.reduce((acc, item) => {
                // يجب التأكد من وجود shopAreaId وقيمة التوصيل
                if (item.shopAreaId) {
                    // نستخدم قيمة التوصيل الأساسية لكل متجر وهي 'delivery' من الكود القديم
                    const fee = item.deliveryFee; 
                    ;
                   
                    if (!acc[item.shopAreaId]) {
                        acc[item.shopAreaId] = [];
                    }
                    acc[item.shopAreaId].push(fee);
                }
                return acc;
            }, {});

            // 2. حساب رسوم التوصيل النهائية (المخفضة) وتحديد قيمة الخصم

            for (const areaId in areaFees) {
               
                const fees = areaFees[areaId];
                const sumFees = fees.reduce((sum, fee) => sum + fee, 0); // مجموع رسوم المنطقة الواحدة
                
                // الشرط: إذا كان هناك أكثر من متجر يشترك في نفس المنطقة (مثل 3 و 3)
                if (fees.length > 1) {
                    
                    // حساب قيمة الخصم للمجموعة المتشابهة
                    const areaDiscount = sumFees * DISCOUNT_RATE;
        
                    // تجميع قيمة الخصم الكلية
                    discountAmount += areaDiscount; 
        
                    // إضافة المجموع المخفض إلى التكلفة الإجمالية بعد الخصم
                    discountedDelivery += sumFees - areaDiscount;

        
                } else {
                    // المنطقة فريدة (مثل 2) - لا يوجد خصم، تُضاف التكلفة كاملة
                    discountedDelivery += sumFees;
                }
            }

            // الآن المتغيرات لديك محدثة:
            // * discountAmount: يحتوي على إجمالي الخصم المطبق (مثلاً 49 في مثالك)
            // * discountedDelivery: يحتوي على إجمالي رسوم التوصيل النهائية بعد تطبيق الخصم (مثلاً 151 في مثالك)


            // =====================================

            const summary = {
                subtotal: rawSubtotal.toFixed(2),          // raw subtotal of items
                delivery: discountedDelivery.toFixed(2),   // delivery after discount
                total: (rawSubtotal + discountedDelivery).toFixed(2), // total includes discounted delivery
                discount: discountAmount.toFixed(2),       // only delivery discount
            };

            localStorage.setItem("cartSummary", JSON.stringify(summary));
        }


    ,

        getSubtotal() {
            return this.items.reduce((sum, item) => {
                const price = Number(item.price) || 0;
                return sum + price * item.amount;
            }, 0);
        },


        addItem(item) {
            const differentAreaExists = this.items.some(i => i.areaId !== GLOBAL_AREA_ID);

            if (differentAreaExists) {
                Swal.fire({
                    title: texts.CannotAddDifferentAreaTitle,
                    text: texts.CannotAddDifferentAreaText,
                    icon: "error",
                    confirmButtonText:texts.Ok,
                });
                return; // وقف كل حاجة
            }



            // Check if the shop already exists in the cart
            const shopExists = this.items.some(i => i.shopId === GLOBAL_shop_ID);

            // ⚠️ Different shop, first product of a new shop
            if (!shopExists && this.items.length > 0) {
                const newItem = {
                  ...item,
                        amount: 1,
                    placeId: GLOBAL_PLACE_ID,
                areaId: GLOBAL_AREA_ID,
                deliveryFee: GLOBAL_DELIVERY_FEE,
                shopId: GLOBAL_shop_ID,
                shopName: GLOBAL_shopName,
                shopAreaId: GLOBAL_shopArea_ID,
                addId: GLOBAL_addid_ID
            };

            Swal.fire({
                title: texts.AddItemDifferentShopTitle,
                text: texts.AddItemDifferentShopText,
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: texts.YesAdd,
                cancelButtonText: texts.Cancel,
                reverseButtons: true,
            }).then((result) => {
                if (result.isConfirmed) {
                    cart.items.push(newItem); // ✅ use cart instead of this
                    cart.save(); // ✅ use cart.save()
                    showCartToast(texts.AddedFromDifferentShop); 
                }
            });

            // Optional: update UI immediately
            updateCartUI();
            updateCartCounter();
            updateTotalPayAmount();

            console.log("Adding item to shop:", currentShopId, currentShopName);


            return;
        }



        // ✅ Normal flow: find existing item by both id and shopId
            const existing = this.items.find(i => i.id === item.id && i.shopId === GLOBAL_shop_ID);
    if (existing) {
        existing.amount += 1;
    } else {
        this.items.push({
          ...item,
                amount: 1,
        placeId: GLOBAL_PLACE_ID,
        areaId: GLOBAL_AREA_ID,
        deliveryFee: GLOBAL_DELIVERY_FEE,
        discountedDelivery:
        item.deliveryFee -
        (item.deliveryFee * (GLOBAL_AREA_DISCOUNT / 100) || 0),
        shopId: GLOBAL_shop_ID,
        shopName: GLOBAL_shopName,
        shopAreaId: GLOBAL_shopArea_ID,
        addId: GLOBAL_addid_ID,
        });
}

        this.save();
},



removeItem(id, shopId) {
    // Remove the specific product from a specific shop
    this.items = this.items.filter(i => !(i.id === id && i.shopId === shopId));
    this.save();
},

increaseItem(id, shopId) {
    const existing = this.items.find(i => i.id === id && i.shopId === shopId);
    if (existing) {
        existing.amount += 1;
        this.save();
    }
},

        decreaseItem(id, shopId) {
            const existing = this.items.find(i => i.id === id && i.shopId === shopId);
            if (!existing) return;

            existing.amount -= 1;
            if (existing.amount <= 0) {
                this.removeItem(id, shopId);
            } else {
                this.save();
            }
        }

};

const cartData = JSON.parse(localStorage.getItem("cartItems")) || [];
const cartSummary = JSON.parse(localStorage.getItem("cartSummary")) || {};
renderCheckoutArticles(cartData, cartSummary);



const placeIdEl = document.querySelector("#placeId");
const areaIdEl = document.querySelector("#areaId");
const shopAreaIdEl = document.querySelector("#shopAreaId");
const shopIdEl = document.querySelector("#shopId"); // you said id="shopId"
const shopNameEl = document.querySelector("#shopName");
const addidEl = document.querySelector("#addid");
// if (shopAreaIdEl) {
//    localStorage.setItem("currentShopAreaId", shopAreaIdEl.textContent.trim());
// }
const areaDiscountEl = document.querySelector("#areaDiscountPercentage");
let GLOBAL_AREA_DISCOUNT = areaDiscountEl
    ? parseFloat(areaDiscountEl.textContent.trim().replace("%", "")) || 0
    : parseFloat(localStorage.getItem("GLOBAL_AREA_DISCOUNT")) || 0;

let GLOBAL_PLACE_ID = placeIdEl ? placeIdEl.textContent.trim() : null;
let GLOBAL_AREA_ID = areaIdEl ? areaIdEl.textContent.trim() : null;
let GLOBAL_shop_ID = shopIdEl ? shopIdEl.textContent.trim() : null;
let GLOBAL_addid_ID = addidEl ? addidEl.textContent.trim() : null;
let GLOBAL_shopArea_ID = shopAreaIdEl ? shopIdEl.textContent.trim() : null;

let GLOBAL_DELIVERY_FEE =
    parseFloat(localStorage.getItem("GLOBAL_DELIVERY_FEE")) || 0;

const deliveryFeeEl = document.querySelector("#deliveryFee");
if (deliveryFeeEl) {
    const fee = parseFloat(deliveryFeeEl.textContent.trim());
    if (!isNaN(fee)) {
        GLOBAL_DELIVERY_FEE = fee;
        localStorage.setItem("GLOBAL_DELIVERY_FEE", fee); // ✅ save it
    }
}

let GLOBAL_shopName= shopNameEl.textContent.trim();

function showCartToast(message = texts.AddedToCartDefault, options = {}) { 
    const {
        background = "#ffc119", // toast background
          color = "#fff", // text color
          icon = "success",
        } = options;

    const progressColor = icon === "success" ? "#a5dc86" : "#ffeb3b";

    // Responsive position & scale
    const isMobile = window.innerWidth <= 600;
    const position = isMobile ? "top" : "top-end";
    const width = isMobile ? "90%" : "auto";
    const customPadding = isMobile ? "0.5em" : "";

    Swal.fire({
        toast: true,
        position: position,
        icon: icon,
        title: message,
        showConfirmButton: false,
        timer: 1500,
        timerProgressBar: true,
        background: background,
        color: color,
        width: width,
        padding: customPadding,
        customClass: {
            timerProgressBar: 'custom-toast-progress'
        },
        didOpen: (toast) => {
            toast.addEventListener("mouseenter", Swal.stopTimer);
            toast.addEventListener("mouseleave", Swal.resumeTimer);
        },
    });

    // Inject custom style for this toast instance
    const style = document.createElement("style");
    style.textContent = `
    .swal2-container .custom-toast-progress {
      background: ${progressColor} !important;
    }
  `;
    document.head.appendChild(style);
}




    function getCartItems() {
        return JSON.parse(localStorage.getItem("cartItems")) || [];
    }

    const items = getCartItems();



    /* ========== COUNTER ========== */
    function updateCartCounter() {
        const counter = document.querySelector("#cartItemsNumber");
        if (!counter) return;
        const total = cart.items.reduce((sum, item) => sum + item.amount, 0);
        counter.textContent = total;
        if (total > 0) {
            counter.textContent = total;
            counter.style.display = "inline"; // or "block", depending on your layout
        } else {
            counter.style.display = "none";
        }
    }

    /* ========== TOTAL PAY (for mobile/cart icon bar) ========== */
    function updateTotalPayAmount() {
        const el = document.querySelector("#totalPayAmount");
        if (!el) return;

        const hasItems = cart.items.length > 0;

        if (!hasItems) {
            // Cart empty → show zeros
            el.textContent = `${texts.Total}: EGP 00.00`; 
            return;
        }

        // Cart has items → use cart summary
        const summary = JSON.parse(localStorage.getItem("cartSummary")) || {
            total: 0
        };

        el.textContent = `${texts.Total}: EGP ` + Number(summary.total).toFixed(2); 
    }


    /* ========== MAIN CART UI (Popup Cart) ========== */
    function updateCartUI() {
        const inCart = document.querySelector("#inCartItems");
        const empty = document.querySelector("#emptyCart");
        if (!inCart || !empty) return;

        // Remove old wrapper if exists
        const oldWrapper = inCart.querySelector(".orderedItemsWrapper");
        if (oldWrapper) oldWrapper.remove();

        // Show empty message if cart is empty
        if (cart.items.length === 0) {
            empty.style.display = "flex";
            inCart.style.display = "none";
            cart.saveSummary();
            updateCartCounter();
            updateTotalPayAmount();
            renderCheckoutArticles(cart.items, JSON.parse(localStorage.getItem("cartSummary")) || {});
            return;
        }

        empty.style.display = "none";
        inCart.style.display = "flex";

        // Create wrapper for items
        const wrapper = document.createElement("div");
        wrapper.classList.add("orderedItemsWrapper");

        const preDeliveryEl = inCart.querySelector(".preDeliveryFeeAmount");
        if (preDeliveryEl) {
            inCart.insertBefore(wrapper, preDeliveryEl);
        } else {
            inCart.appendChild(wrapper);
        }

        // Group items by shopId
        const itemsByShop = {};
        cart.items.forEach(item => {
            if (!itemsByShop[item.shopId]) {
                itemsByShop[item.shopId] = {
                    shopName: item.shopName || texts.DefaultShopName, 
                    items: []
                };
            }
            itemsByShop[item.shopId].items.push(item);
        });

        // Render each shop group
        Object.keys(itemsByShop).forEach(shopId => {
            const group = itemsByShop[shopId];

            // Shop label
            const shopLabel = document.createElement("div");
            shopLabel.classList.add("cartShopLabel");
            shopLabel.textContent = group.shopName;
            wrapper.appendChild(shopLabel);

            // Render each product in shop
            group.items.forEach(item => {
                const priceNum = Number(item.price) || 0;
                const totalPrice = priceNum * item.amount;

                const article = document.createElement("article");
                article.classList.add("orderedItem");
                article.innerHTML = `
        <div class="cartItemAmountHandlers">
          <button class="decrease" type="button">-</button>
          <span class="itemAmount">${item.amount}</span>
          <button class="increase" type="button">+</button>
        </div>
        <span class="orderedItemName">${item.name}</span>
        <span class="totalItemPrice">${totalPrice.toLocaleString()} ${texts.Currency}</span>
        <span class="removeCartItem">✕</span>
      `;
                wrapper.appendChild(article);

                // Buttons
                article.querySelector(".increase").onclick = () => cart.increaseItem(item.id, item.shopId);
                article.querySelector(".decrease").onclick = () => cart.decreaseItem(item.id, item.shopId);
                article.querySelector(".removeCartItem").onclick = () => cart.removeItem(item.id, item.shopId);
            });
        });

        // Update totals
        cart.saveSummary();
        updateCartCounter();
        updateTotalPayAmount();

        // Update subtotal, delivery,  total in the popup
        const summary = JSON.parse(localStorage.getItem("cartSummary")) || {
            subtotal: 0,
            delivery: cart.deliveryFee,
            total: 0
        };

        const subtotalEl = document.querySelector(".subtotalAmount");
        const deliveryEls = document.querySelectorAll(".deliveryFee");
        const totalEl = document.querySelector(".totalAmount");

        if (subtotalEl) subtotalEl.textContent = Number(summary.subtotal).toLocaleString() + ` ${texts.Currency}`; 
        if (deliveryEls.length >= 1) deliveryEls[0].textContent = Number(summary.delivery).toFixed(2) + ` ${texts.Currency}`; 
        if (totalEl) totalEl.textContent = Number(summary.total).toLocaleString() + ` ${texts.Currency}`; 
    }



    /* ========== ADD TO CART BUTTONS ========== */
    function initAddToCartByCard() {
        const foodItems = document.querySelectorAll(".foodItem");

        foodItems.forEach((itemEl) => {
            itemEl.addEventListener("click", (e) => {

                // Ignore clicks on buttons inside the item
                if (e.target.closest("button")) return;

                const id = itemEl.getAttribute("id");
                const name = itemEl.querySelector(".foodName")?.textContent.trim();
                const price = itemEl.querySelector(".foodNewPrice")?.textContent.trim();

                if (id && name && price) {
                    // Load clicked IDs from localStorage
                    let clickedIds = JSON.parse(localStorage.getItem("clickedProductIds")) || [];

                    // Only add to clicked IDs if not already present
                    const isNewClick = !clickedIds.includes(id);
                    if (isNewClick) {
                        clickedIds.push(id);
                        localStorage.setItem("clickedProductIds", JSON.stringify(clickedIds));
                    }

                    // Add item to cart
                    cart.addItem({
                        id, // unique product ID
                        name,
                        price: parseFloat(price.replace(/[^\d.]/g, "")),
                        placeId: GLOBAL_PLACE_ID,
                        areaId: GLOBAL_AREA_ID,
                        deliveryFee: GLOBAL_DELIVERY_FEE,
                        shopId: GLOBAL_shop_ID,
                        shopName: GLOBAL_shopName,
                        shopAreaId: GLOBAL_shopArea_ID,
                        addId: GLOBAL_addid_ID

                    });


                    // Show toast ONLY if first time clicked
                    if (isNewClick) {
                        showCartToast(`${texts.AddedToCartPrefix} "${name}" ${texts.AddedToCartSuffix}`); 
                    }

                    console.log("Clicked product IDs:", clickedIds);
                }
            });
        });
    }


    // ✅ Function to empty the cart
    function attachEmptyCartButton(buttonSelector, options = {}) {
const btn = document.querySelector(buttonSelector);
    if (!btn) return;

    btn.addEventListener("click", () => {
        const doEmpty = () => {
            cart.items = [];
            cart.save();
            if (options.clearClickedIds) {
                localStorage.setItem("clickedProductIds", JSON.stringify([]));
            }
            if (options.toastMessage) {
                showCartToast(options.toastMessage);
            }
        };

        if (options.confirm) {
            Swal.fire({
                title: options.confirmMessage || texts.ConfirmEmptyCart,
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: texts.Ok,
                cancelButtonText: texts.Cancel,
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    doEmpty();
                }
            });
        } else {
            doEmpty();
        }
    });
}

attachEmptyCartButton("#emptyCartBtn", {
    confirm: true,
    confirmMessage: texts.ConfirmEmptyCart,
    toastMessage: texts.CartEmptied,
    clearClickedIds: true,
});


/* ========== CHECKOUT PAGE LOADER ========== */
function loadCheckoutSummary() {
    if (!window.location.pathname.includes("checkout")) return;
    const stored = localStorage.getItem("cartSummary");
    if (!stored) return;
    const {
        subtotal,
        delivery,
        total
    } = JSON.parse(stored);
    const subtotalEl = document.querySelector(".subtotalAmount");
    const deliveryEl = document.querySelectorAll(".deliveryFee")[0];
    const totalEl = document.querySelector(".totalAmount");
    if (subtotalEl) subtotalEl.textContent = subtotal + ` ${texts.Currency}`; 
    if (deliveryEl) deliveryEl.textContent = delivery + ` ${texts.Currency}`; 
    if (totalEl) totalEl.textContent = total + ` ${texts.Currency}`; 
}



/* ========== INITIALIZE EVERYTHING ========== */
initAddToCartByCard();
updateCartUI();
updateCartCounter();
updateTotalPayAmount();
loadCheckoutSummary();

// Fallback for lazy DOM content
setTimeout(() => {
    updateCartUI();
    updateCartCounter();
    updateTotalPayAmount();
}, 300);

// ✅ Make accessible globally for debugging
// Make accessible globally for debugging

// --- SMART CART ICON REDIRECT ---
const cartIcon = document.querySelector("#cartIcon");

function updateCartIconLink() {
    if (!cartIcon) return;

    const cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];

    if (cartItems.length === 0) {
        // Cart is empty
        const lastShopId = localStorage.getItem("currentShopId");

        if (lastShopId) {
            // Redirect to last visited shop
            cartIcon.setAttribute("href", `./shopPage.html?shopId=${lastShopId}`);
        } else {
            // No history → go to all shops
            cartIcon.setAttribute("href", "./allShops.html");
        }
    } else {
        // Cart has items → go to checkout
        cartIcon.setAttribute("href", "./checkout.html");
    }
}

// Run once on page load
updateCartIconLink();


function renderCheckoutArticles(items, summary) {
    const checkoutCart = document.querySelector("#checkoutCart");
    if (!checkoutCart) return;

    checkoutCart.innerHTML = "";

    if (items.length === 0) {
        const emptyMsg = document.createElement("p");
        emptyMsg.textContent = texts.CartIsEmpty; 
        checkoutCart.appendChild(emptyMsg);
        return;
    }

    // Group items by shop
    const itemsByShop = {};
    items.forEach(item => {
        if (!itemsByShop[item.shopId]) itemsByShop[item.shopId] = { shopName: item.shopName, items: [] };
        itemsByShop[item.shopId].items.push(item);
    });

    Object.keys(itemsByShop).forEach(shopId => {
        const shopGroup = itemsByShop[shopId];

        const article = document.createElement("article");
        article.classList.add("checkoutBox");

        // Shop title + edit link
        const titleDiv = document.createElement("div");
        titleDiv.classList.add("checkoutBoxTitle");

        const addId = shopGroup.items[0].addId || "";

        function sendAddId(addId) {
            $.ajax({
                type: "POST",
                url: "CheckOut.aspx/ReceiveAddId",
                data: JSON.stringify({ addId: addId, lang: getCookie("lang") || "ar" }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",  // مهم جداً
                success: function(res) {
                    
                    var data = res.d;
                    // تحديث العناصر مباشرة
                    document.getElementById("AddName").innerText = data.AddName;
                    document.getElementById("StreetName").innerText = data.StreetName;
                    document.getElementById("mobile").innerText = data.mobile;
                    document.getElementById("location").innerText = data.Gov+'-'+data.Area;
                    document.getElementById("phone").innerText = data.phone;
                    document.getElementById("Build").innerText = data.Build;
                    document.getElementById("Floor").innerText = data.Floor;

                    document.getElementById("Area").innerText = data.Area;
                    document.getElementById("Gov").innerText = data.Gov;
                    document.getElementById("AdepartmentNo").innerText = data.AdepartmentNo;

                    document.getElementById("Instructions").innerText = data.Instructions;
                    document.getElementById("AType").innerText = data.AType;
                    
                    // تحديث HiddenField لو عايز تحتفظ بالـ addId
                    document.getElementById("ContentPlaceHolder1_hfAddId").value = addId;
                },
                error: function(err) {
                    console.log("AJAX Error:", err);
                }
            });
        }


        sendAddId(addId);
        titleDiv.innerHTML = `
      <h2>${shopGroup.shopName}</h2>
      <a href="PlaceShop.aspx?id=${shopId}&addid=${addId}">${texts.UpdateOrder}</a>
    `;
        article.appendChild(titleDiv);

        // Order info container
        const orderInfo = document.createElement("div");
        orderInfo.classList.add("orderInfo");

        // Labels row
        const labels = document.createElement("div");
        labels.classList.add("orderLabels");
        labels.innerHTML = `
      <span class="orderName">${texts.Item}</span>
      
      <span>${texts.Quantity}</span>
      <span>${texts.Price}</span>
      <span>${texts.Total}</span>
      <span>${texts.Remove}</span>
    `;
        orderInfo.appendChild(labels);

        // Each item row
        shopGroup.items.forEach(item => {
            const totalPrice = (item.price * item.amount).toFixed(2);
            const row = document.createElement("div");
            row.classList.add("orderStats");

            row.innerHTML = `
        <span class="orderName">${item.name} <span class="specialOrder"></span></span>
        
        <div class="cartItemAmountHandlers">
          <button class="decrease">-</button>
          <span class="itemAmount">${item.amount}</span>
          <button class="increase">+</button>
        </div>
        <span class="itemPrice">${item.price.toFixed(2)} ${texts.Currency}</span>
        <span class="itemTotal">${totalPrice} ${texts.Currency}</span>
        <span class="removeItem"><i class="fa-solid fa-trash"></i></span>
      `;
            orderInfo.appendChild(row);

            // Handlers
            row.querySelector(".increase").onclick = () => cart.increaseItem(item.id, item.shopId);
            row.querySelector(".decrease").onclick = () => cart.decreaseItem(item.id, item.shopId);
            row.querySelector(".removeItem").onclick = () => cart.removeItem(item.id, item.shopId);
        });

        article.appendChild(orderInfo);
        checkoutCart.appendChild(article);
    });

    // TOTAL AMOUNT article
    const totalArticle = document.createElement("article");
    totalArticle.classList.add("checkoutBox", "totalAmountBox");
    totalArticle.innerHTML = `
    <div class="checkoutBoxTitle">
      <h2>${texts.Total}</h2>
    </div>
    <div class="orderInfo">
      <div class="orderStats">
        <span>${texts.Subtotal}:</span>
        <span>${Number(summary.subtotal || 0).toLocaleString()} ${texts.Currency}</span>
      </div>
      <div class="orderStats">
        <span>${texts.DeliveryFee}:</span>
        <span id="Deliverycost">
    ${(() => {
        let value = Number(summary.delivery || 0);
        return (value % 1 === 0 ? value : value.toFixed(2)) + ` ${texts.Currency}`;
    })()}
</span>
      </div>
      <div class="orderStats" style="font-weight: bold;">
        <span>${texts.FinalTotal}:</span>
        <span>${Number(summary.total || 0).toLocaleString()} ${texts.Currency}</span>
      </div>
    </div>
  `;
    checkoutCart.appendChild(totalArticle);
}
});