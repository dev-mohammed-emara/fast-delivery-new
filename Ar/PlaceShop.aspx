<%@ Page Title="" Language="C#" MasterPageFile="~/Ar/MasterPages/MasterPage.master" AutoEventWireup="true"
    CodeFile="PlaceShop.aspx.cs" Inherits="Ar_PlaceShop" %>
    <asp:Content ID="Content3" ContentPlaceHolderID="head" Runat="Server">

        <asp:Literal ID="ltPageTitle" runat="server" Text="<%$ Resources:texts, PagePlaceShopTitle %>"></asp:Literal>
    </asp:Content>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true" />
        <style>
            .header {
                display: grid;
                grid-template-columns: 1fr auto 1fr;
                align-items: center;
                padding: 6px 50px;
                background: linear-gradient(135deg, #fffbe6 0%, #ffffff 0%, #fffbe6 10%);
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 100;
                transition: background-color 0.3s, box-shadow 0.3s;
            }

            #openedShopFoods {
                padding-top: 125px;
                padding-inline: 25px;
                padding-bottom: 50px;
                position: relative;
                /* isolation: isolate; */
                margin: auto;
                max-width: 1140px;
                width: 100%;

                h2 {
                    display: flex;
                    justify-content: space-between;
                    gap: 1rem;
                    align-items: start;
                    line-height: 1.2;
                }

                #filterIcon {
                    display: none;
                }
            }

            .availableShop {
                display: flex;
                gap: 1.5rem;
                margin-top: 1rem;
                /* border-bottom: 1px solid rgba(0, 0, 0, 0.25); */
                padding: 1rem;
                transition: var(--transition);

                img {
                    width: 120px;
                    height: 120px;
                    aspect-ratio: 1;
                    object-position: center;
                    object-fit: cover;
                    border: 1px solid rgba(0, 0, 0, 0.25);
                    border-radius: 0.5rem;
                }

                &:hover {
                    background-color: whitesmoke;

                    .availableShopName {
                        color: var(--fd-blue);
                    }
                }
            }

            .shopDelivery {
                display: flex;
                column-gap: 1rem;
                flex-wrap: wrap;
                font-size: 0.9rem;
                align-items: center;
                white-space: nowrap;
            }

            .shopPayMethods {
                display: flex;
                gap: 1rem;
                align-items: center;
                /* width: fit-content; */
                margin-top: 0.5rem;

                img {
                    width: 40px;
                    object-fit: contain;
                    height: 30px;
                    border-radius: 0 !important;
                    border: none !important;
                }
            }

            .availableShopDesc {
                display: flex;
                flex-direction: column;
            }

            .availableShopName,
            .shopFoods {
                line-height: 1.5;
                margin-bottom: 0.5rem;
                transition: var(--transition);
            }



            .shopRating {
                display: flex;
                gap: 0.5rem !important;
                font-size: 0.9rem;
                align-items: baseline;

                i {
                    color: var(--fd-blue);
                }
            }



            #shopListsOptions {
                display: flex;
                margin-block: 25px;
                border-bottom: 1px solid rgba(0, 0, 0, 0.25);
                padding-inline: 0.5rem;
                flex-wrap: wrap;
                justify-content: space-evenly;
                gap: 1rem;
                box-sizing: border-box;
                list-style: none;

                li {
                    display: flex;
                    gap: 0.5rem;
                    text-align: center;
                    flex-basis: 25%;
                    position: relative;
                    font-weight: bold;
                    justify-content: center;
                    white-space: nowrap;
                    align-items: center;
                    cursor: pointer;
                    padding-bottom: 0.5rem;
                    transition: var(--transition);
                    font-size: 1.25rem;

                    i {
                        font-size: 1.5rem;
                        color: var(--fd-blue);
                    }

                    &:hover {
                        color: var(--fd-blue);
                    }

                }
            }



            #shopLists li.active {
                color: var(--fd-blue);
                border-color: var(--fd-blue);

                &:after {
                    content: '';
                    background-color: transparent;
                    z-index: -1;
                    border-bottom: 5px solid var(--fd-blue);
                    width: 100%;
                    height: 100%;
                    clip-path: polygon(20% 0%, 80% 0%, 100% 100%, 0% 100%);
                    position: absolute;
                    bottom: 0;
                    left: 0;
                }
            }



            #openedShopFoods {
                .inputHolder {
                    position: relative;
                    width: 100%;
                    isolation: isolate;

                    .showPassword {
                        color: #444 !important;
                    }

                    input {
                        padding: 0.5rem 1rem;
                        border-radius: 0.25rem;
                        border: 1px solid rgba(0, 0, 0, 0.25);
                        width: 100%;
                    }

                    .showPassword {
                        position: absolute;
                        left: 0;
                        top: 0;
                        height: fit-content;
                        font-size: 1.25rem;
                        bottom: 0;
                        margin: auto;
                    }
                }
            }

            #shopGrid {
                display: grid;
                grid-template-columns: 65% 30%;
                /* gap: 1rem; */
            }

            #shopFoodLists {
                display: grid;
                grid-template-columns: 30% 65%;
                gap: 1rem;
            }

            #foodListsNav {
                display: flex;
                flex-direction: column;
                position: sticky;
                max-height: 450px;
                will-change: auto;
                overflow-y: auto;
                -webkit-overflow-scrolling: touch;
                overscroll-behavior: contain;
                touch-action: pan-y;
                top: 100px;
                line-height: 1.2;
                height: fit-content;
                border-radius: 0.25rem;
                padding: 0.5rem;
                border: 1px solid rgba(0, 0, 0, 0.125);

                .foodNavLinks {
                    display: flex;
                    flex-direction: column;

                    a {
                        padding: 1rem 0.5rem;
                        transition: var(--transition);

                        &:hover {
                            background-color: whitesmoke;
                            color: var(--fd-blue);
                        }
                    }
                }
            }


            #foodListsHolder {
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }

            .foodListTitle {
                background-color: whitesmoke;
                padding: 0.5rem;

                i {
                    transition: var(--transition);
                    cursor: pointer;

                    &:hover {
                        rotate: 180deg;

                        color: var(--fd-blue);

                    }
                }


            }

            .foodListTitle.active {
                i {
                    color: var(--fd-blue);
                    rotate: 180deg;
                }
            }

            .foodDrowdown {
                display: flex;
                flex-direction: column;
                list-style: none;
                gap: 1rem;
                transition: all 1000ms linear(0,
                        0.012 0.9%,
                        0.05 2%,
                        0.411 9.2%,
                        0.517 11.8%,
                        0.611 14.6%,
                        0.694 17.7%,
                        0.765 21.1%,
                        0.824 24.8%,
                        0.872 28.9%,
                        0.91 33.4%,
                        0.939 38.4%,
                        0.977 50.9%,
                        0.994 68.4%,
                        1);
                transform-origin: bottom;
                interpolate-size: allow-keywords;
                overflow:initial;
                height: auto;
                padding:0px;
            }

            .foodDrowdown.active {
                height: 0;
                overflow:hidden;
            }

            .foodList {
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }



            .foodItem {
                display: flex;
                align-items: center;
                justify-content: space-between;
                column-gap: 1rem;
                row-gap: 4px;
                padding: 1rem 0.5rem;
                cursor: pointer;
                transition: var(--transition);
                border-bottom: 1px solid rgba(0, 0, 0, 0.125);

                &:hover {
                    background-color: whitesmoke;

                    .foodName {
                        color: var(--fd-blue);
                    }
                }
            }

            .foodImage {
                display: flex;
                min-width: 80px;
                max-width: 80px;
                height: 80px;
                border-radius: 0.25rem;
                justify-content: center;
                align-items: center;
                padding: 0.5rem;
                border: 1px solid rgba(0, 0, 0, 0.25);

                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    aspect-ratio: 1;
                    border-radius: inherit;
                }
            }

            .foodDetails {
                display: flex;
                align-items: center;
                column-gap: 1rem;
                row-gap: 4px;
            }


            .foodName {
                font-size: 0.8rem;
                transition: var(--transition);
            }

            .foodContent {
                opacity: 0.8;
                font-size: 0.8rem;
                text-wrap: balance;
                line-height: 1.2;
            }

            .foodNewPrice,
            .foodOldPrice {
                white-space: nowrap;
                font-weight: bold;
            }

            .foodOldPrice {
                opacity: 0.8;
                text-decoration: line-through;
            }

            .addToCart {
                display: flex;
                justify-content: center;
                align-items: end;
                height: 100%;
                color: var(--fd-blue);
                font-size: 1.5rem;

                .addToCartBtn {
                    height: fit-content;
                    cursor: pointer;
                    transition: var(--transition);

                    &:hover {
                        color: var(--fd-red);
                        scale: 1.05;
                    }
                }
            }


            #cartHolder {
                display: flex;
                flex-direction: column;
                border-radius: 0.5rem;
                overflow: hidden;
                max-width: 600px;
                width: 100%;
                position: sticky;
                isolation: isolate;
                top: 100px;
                height: fit-content;
            }

            #closeCartBtn {
                width: fit-content;
                right: initial;
                display: none;
                left: 10px;
            }

            .shoppingCartTitle {
                background-color: var(--fd-blue);
                color: white;

                padding: 0.5rem;
            }


            #emptyCart {
                display: flex;
                flex-direction: column;
                gap: 1rem;
                justify-content: center;
                border: 1px solid rgba(0, 0, 0, 0.125);
                border-bottom-left-radius: inherit;
                border-bottom-right-radius: inherit;
                align-items: center;
                text-align: center;
                background-color: whitesmoke;
                font-size: 1rem;
                padding: 2rem;
                font-weight: bold;
                line-height: 1.2;

                i {
                    font-size: 5rem;
                    color: #444;
                }
            }


            #cartShower {
                position: fixed;
                bottom: 0;
                color: white;
                left: 0;
                width: 100%;
                display: none;
                gap: 1rem;
                justify-content: space-between;
                align-items: center;
                padding: 0.5rem 1rem;
                z-index: 100;
                background-color: var(--fd-dark);

                .submit {
                    padding-block: 0.25rem;
                    margin: 0;
                }
            }

            #totalPayAmount {
                white-space: nowrap;
                font-size: 1rem;
            }

            #foodImageModal {
                width: 400px;
                height: 400px;
                background-color: white;
                border: 1px solid rgba(0, 0, 0, 0.125);
                box-shadow: var(--shadow);
                position: fixed;
                z-index: 1000;
                padding: 1rem;
                border-radius: 0.5rem;
                pointer-events: none;

                opacity: 0;
                transform: translate(0, 0);
                transition: opacity 0.2s ease, transform 0.2s ease;
            }

            #foodImageModal.show {
                opacity: 1;
                transform: translate(5px, 5px);
                /* small shift for smooth effect */
            }

            #foodImageModal img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: inherit;
            }

            #foodImageModal::after {
                content: '';
                position: absolute;
                width: 30px;
                height: 30px;
                background-color: white;
                border-top: 1px solid rgba(0, 0, 0, 0.125);
                border-right: 1px solid rgba(0, 0, 0, 0.125);
                rotate: 45deg;
                right: -16px;
                top: var(--arrow-top, 50%);
                aspect-ratio: 1;
                z-index: -1;
            }

            #inCartItems {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
                justify-content: center;
                font-size: 1rem;
                background-color: white;
                font-weight: bold;
                line-height: 1.2;
                border: 1px solid rgba(0, 0, 0, 0.125);
                padding: 1rem 0rem;
                border-bottom-left-radius: inherit;
                border-bottom-right-radius: inherit;
            }

            .orderedItem {
                display: flex;
                gap: 0.5rem;
                border-top: 1px solid rgba(0, 0, 0, 0.125);
                border-bottom: 1px solid rgba(0, 0, 0, 0.125);

                padding: 0.5rem;
                font-size: 0.75rem;
                align-items: center;
                justify-content: space-between;
                background-color: whitesmoke;
            }

            .removeCartItem {
                background-color: red;
                color: white;
                border-radius: 50%;
                width: 1rem;
                height: 1rem;
                font-size: 1rem;
                cursor: pointer;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .cartItemAmountHandlers {
                background-color: white;
                border: 1px solid rgba(0, 0, 0, 0.125);
                padding: 0.25rem;
                font-size: 0.9rem;
                border-radius: 0.25rem;
                overflow: hidden;
                font-weight: bold;
                display: flex;
                align-items: center;
            }

            .increase,
            .decrease {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 0.25rem;
                border: none;
                font-weight: bold;
                height: 30px;
                background-color: transparent;
                font-size: 1rem;
                border-radius: inherit;
                transition: var(--transition);
                color: var(--fd-blue);

                &:hover {
                    background-color: var(--fd-blue);
                    color: white;
                }
            }

            .increase {
                border-right: 1px solid rgba(0, 0, 0, 0.125);

            }

            .decrease {
                border-left: 1px solid rgba(0, 0, 0, 0.125);

            }

            .itemAmount {
                border-radius: inherit;
                padding: 0.25rem;
            }

            #cartShopLabel {
                /* padding-block: 0.5rem; */
                margin-inline: 0.5rem;
                font-weight: bold;
            }

            .preDeliveryFeeAmount,
            .deliveryAmount,
            .afterDeliveryFeeAmount {
                display: flex;
                gap: 1rem;
                justify-content: space-between;
                align-items: center;
                padding-inline: 0.5rem;
                font-size: 0.9rem;

                p {
                    display: flex;
                    gap: 2px;
                    align-items: center;
                }
            }

            /* تنسيق شريط التصنيفات (Food Categories Bar) */
            .food-categories-mobile-bar {
                width: 100%;
                display: block;
                /* لعرض الموبايل */
                padding: 10px 0;
                background-color: #fff;
                /* خلفية بيضاء نظيفة */
                margin-bottom: 15px;
                box-shadow: none;
                /* إزالة الظل */
            }

            /* حاوية التمرير الأفقي */
            .categories-list-scroll {
                display: flex;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
                overscroll-behavior: contain;
                touch-action: pan-x pan-y;
                gap: 20px;
                /* مسافة أكبر بين الكلمات */
                padding: 0 15px;
                justify-content: flex-start;
                /* ترتيب العناصر من البداية */
            }

            /* 2. تنسيق عنصر التصنيف (الكلمة فقط) */
            .category-pill {
                /* ألغينا Flexbox هنا لأننا لا نحتاج لترتيب الصورة والنص */
                display: inline-block;
                padding: 5px 0;
                /* مسافة حول النص (أعلى وأسفل) */
                color: #888;
                /* لون رمادي خفيف للنص غير النشط */
                text-decoration: none;
                font-size: 16px;
                font-weight: 500;
                white-space: nowrap;
                /* منع النص من النزول لسطر جديد */
                border-radius: 0;
                /* لا نحتاج لأي زوايا مستديرة */
                border: none;
                /* إزالة أي إطار أو خلفية */
                transition: color 0.2s;
                flex-shrink: 0;
            }

            /* 3. إلغاء تنسيق الصور تماماً (للتأكد) */
            .category-pill img {
                display: none;
                /* إخفاء الصورة تماماً */
            }

            /* حالة العنصر النشط */
            .category-pill.active {
                color: #ffc119;
                /* لون النص يصبح مميزاً */

                /* ✅ الأهم: إنشاء الخط السفلي */
                border-bottom: 3px solid #ffc119;
            }
        </style>
        <script>
            // Function to handle click and set the active class
            function setActiveCategory(clickedElement, event) {
                // 1. (اختياري) منع التوجيه الفوري للرابط حتى ننهي عمل JavaScript
                // event.preventDefault(); 

                // 2. جلب جميع عناصر التصنيفات
                const allPills = document.querySelectorAll('.category-pill');

                // 3. إزالة كلاس 'active' من كل العناصر
                allPills.forEach(pill => {
                    pill.classList.remove('active');
                });

                // 4. إضافة كلاس 'active' للعنصر الذي تم النقر عليه
                clickedElement.classList.add('active');

                // 5. (إجراء اختياري) يمكنك هنا استخدام fetch أو AJAX
                // لتحميل قائمة الطعام الجديدة بناءً على ID التصنيف الذي تم اختياره
                // const categoryId = clickedElement.getAttribute('data-category-id');
                // loadFoodItems(categoryId); 

                // 6. إذا كنت تريد استعادة وظيفة التوجيه للرابط بعد انتهاء العملية:
                // window.location.href = clickedElement.href;
            }

            // Function to set the initial active category on page load (from Query String)
            document.addEventListener('DOMContentLoaded', () => {
                // جلب ID التصنيف من رابط URL (Query String)
                const urlParams = new URLSearchParams(window.location.search);
                const initialId = urlParams.get('categoryID') || '1'; // القيمة الافتراضية '1'

                // البحث عن العنصر الذي يطابق الـ ID
                const initialActive = document.querySelector(`.category-pill[data-category-id="${initialId}"]`);

                // تطبيق الكلاس النشط إذا وُجد
                if (initialActive) {
                    initialActive.classList.add('active');
                }
            });
        </script>
        <section id="openedShopFoods">
            <article id="foodImageModal">
                <img src="" alt="zoomed image">
            </article>


            <span class="route"> <a href="Default.aspx">
                    <asp:Literal ID="ltHome" runat="server" Text="<%$ Resources:texts, Home %>"></asp:Literal>
                </a> <i class="fa-solid fa-angles-left"></i>
                <asp:Literal ID="ltlocation" runat="server"></asp:Literal><i class="fa-solid fa-angles-left"></i>
                <asp:Literal ID="ltname2" runat="server"></asp:Literal>
            </span>
            <div id="placeId" hidden>0</div>
            <div id="areaId" hidden>
                <asp:Literal ID="ltareaId" runat="server"></asp:Literal>
            </div>
            <div id="userLocationId" hidden>0</div>
            <div id="deliveryFee" hidden>
                <asp:Literal ID="ltdeliveryFee" runat="server"></asp:Literal>
            </div>
            <div id="shopId" hidden>
                <asp:Literal ID="ltshopId" runat="server"></asp:Literal>
            </div>
            <div id="shopName" hidden>
                <asp:Literal ID="ltshopName" runat="server"></asp:Literal>
            </div>
            <div id="addid" hidden>
                <asp:Literal ID="ltaddid" runat="server"></asp:Literal>
            </div>

            <div id="shopAreaId" hidden>
                <asp:Literal ID="ltshopAreaId" runat="server"></asp:Literal>
            </div>
            <div id="areaDiscountPercentage" hidden>
                <asp:Literal ID="ltPercentage" runat="server"></asp:Literal>%
            </div>


            <a href="#" class="availableShop">
                <div>
                    <asp:Image ID="imgplace" runat="server" />

                    <span class="shopRating" style="text-align:center;padding-top:5px" id="shopRating"
                        runat="server"></span>

                </div>
                <div class="availableShopDesc">
                    <h3 class="availableShopName">
                        <asp:Literal ID="ltname" runat="server"></asp:Literal>
                    </h3>
                    <p class="shopFoods">
                        <asp:Literal ID="ltDetails" runat="server"></asp:Literal>
                    </p>


                    <div class="shopDelivery">
                        <span class="deliveryTime">
                            <asp:Literal ID="ltReceiveIn" runat="server" Text="<%$ Resources:texts, ReceiveIn %>">
                            </asp:Literal>


                            <span class="timer">
                                <asp:Literal ID="ltdeliverytime" runat="server"></asp:Literal>
                            </span>
                            <asp:Literal ID="ltReceiveInMinutes" runat="server"
                                Text="<%$ Resources:texts, ReceiveInMinutes %>"></asp:Literal>

                        </span>
                        <span class="delieveryPayment">
                            <asp:Literal ID="ltDeliveryService" runat="server"
                                Text="<%$ Resources:texts, DeliveryService %>"></asp:Literal>:&nbsp; <asp:Literal
                                ID="ltDeliveryCost" runat="server"></asp:Literal>
                            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:texts, currency %>">
                            </asp:Literal>
                        </span>
                        <span class="minPay">
                            <asp:Literal ID="ltMinOrderText" runat="server" Text="<%$ Resources:texts, MinOrder %>">
                            </asp:Literal>:&nbsp;<asp:Literal ID="ltmincost" runat="server"></asp:Literal>
                        </span>
                    </div>

                    <div class="shopPayMethods">
                        <p>
                            <asp:Literal ID="ltLiveTracking" runat="server" Text="<%$ Resources:texts, LiveTracking %>">
                            </asp:Literal>
                        </p>

                        <p class="circleBadge">
                            <asp:Literal ID="ltSafeDelivery" runat="server" Text="<%$ Resources:texts, SafeDelivery %>">
                            </asp:Literal>
                        </p>

                        <p class="circleBadge" style="color:red">
                            <asp:Literal ID="ltFirstOrderFree" runat="server"
                                Text="<%$ Resources:texts, FirstOrderFree %>"></asp:Literal>
                        </p>
                    </div>

                </div>
            </a>


            <div id="shopLists">
                <ul id="shopListsOptions">
                    <li class="active">
                        <i class="fa-solid fa-utensils"></i>
                        <asp:Literal ID="ltMenu" runat="server" Text="<%$ Resources:texts, Menu %>"></asp:Literal>
                    </li>
                    <li>
                        <i class="fa-solid fa-comments"></i>
                        <asp:Literal ID="ltReviews" runat="server" Text="<%$ Resources:texts, Reviews %>"></asp:Literal>
                    </li>
                    <li>
                        <i class="fa-solid fa-circle-info"></i>
                        <asp:Literal ID="ltShopInfo" runat="server" Text="<%$ Resources:texts, ShopInfo %>">
                        </asp:Literal>
                    </li>
                </ul>


                <div class="food-categories-mobile-bar">
                    <div class="categories-list-scroll">
                        <asp:Repeater ID="FoodCategoryRepeater" runat="server">
                            <ItemTemplate>
                                <%-- يمكنك استخدام المنطق الشرطي لتطبيق active class هنا --%>

                                    <a href='#<%# Eval("id")%>' class="category-pill" data-category-id="<%# Eval(" ID")
                                        %>"
                                        onclick="setActiveCategory(this, event)">

                                        <%-- هذه هي الصورة المصغرة للتصنيف --%>
                                            <%--<img src='<%# Eval("ImagePath") %>' alt='<%# Eval("Name") %>' />--%>
                                            <span>
                                                <%# System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="en"
                                                    ? DataBinder.Eval(Container.DataItem, "NameEn" ) :
                                                    System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="ru"
                                                    ? DataBinder.Eval(Container.DataItem, "NameRu" ) :
                                                    DataBinder.Eval(Container.DataItem, "Name" ) %>
                                            </span>
                                    </a>
                            </ItemTemplate>
                        </asp:Repeater>

                        <%-- مثال ثابت: --%>
                    </div>
                </div>

                <div class="restaurant-content-wrapper">
                </div>

                <section id="shopGrid">
                    <figure id="shopFoodLists">
                        <article id="foodListsNav">
                            <h3>
                                <asp:Literal ID="ltMenuTitle" runat="server" Text="<%$ Resources:texts, MenuTitle %>">
                                </asp:Literal>
                            </h3>
                            <div class="foodNavLinks">

                                <asp:Repeater ID="rptMenu" runat="server">

                                    <ItemTemplate>
                                        <a href='#<%# Eval("id")%>' title='<%# 
        System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName == "en" 
        ? DataBinder.Eval(Container.DataItem, "NameEn") 
        : System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName == "ru"
          ? DataBinder.Eval(Container.DataItem, "NameRu")
          : DataBinder.Eval(Container.DataItem, "Name")
    %>'>
                                            <%# System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="en"
                                                ? DataBinder.Eval(Container.DataItem, "NameEn" ) :
                                                System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="ru"
                                                ? DataBinder.Eval(Container.DataItem, "NameRu" ) :
                                                DataBinder.Eval(Container.DataItem, "Name" ) %>
                                        </a>
                                    </ItemTemplate>
                                </asp:Repeater>



                            </div>
                        </article>

                        <article id="foodListsHolder">
                            <div class="inputHolder">
                                <label for="selectedShopSearcher" class="showPassword"><i
                                        class="fa-solid fa-magnifying-glass"></i></label>
                                <input type="text" name="selectedShopSearcher" id="selectedShopSearcher"
                                    placeholder=<%=Resources.Texts.Search %>>
                            </div>


                            <asp:Repeater ID="rptCategories" runat="server"
                                OnItemDataBound="rptCategories_ItemDataBound">
                                <ItemTemplate>
                                    <div class="foodList" id='<%# Eval("id") %>'>
                                        <h2 class="foodListTitle active">
                                            <%# System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="en"
                                                ? DataBinder.Eval(Container.DataItem, "NameEn" ) :
                                                System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="ru"
                                                ? DataBinder.Eval(Container.DataItem, "NameRu" ) :
                                                DataBinder.Eval(Container.DataItem, "Name" ) %>
                                                <span class="dropDownBtn"><i class="fa-solid fa-angles-down"></i></span>
                                        </h2>

                                        <ul class="foodDrowdown">
                                            <asp:Repeater ID="rptFoodItems" runat="server">
                                                <ItemTemplate>
                                                    <li class="foodItem" id='<%# Eval("id") %>'>
                                                        <span class="foodImage">
                                                            <img src='<%# Eval("PhotoUrl") %>' alt="food image" />
                                                        </span>

                                                        <div class="foodDetails">
                                                            <span class="foodDesc">
                                                                <h4 class="foodName">
                                                                    <%# System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="en"
                                                                        ? DataBinder.Eval(Container.DataItem, "NameEn" )
                                                                        :
                                                                        System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="ru"
                                                                        ? DataBinder.Eval(Container.DataItem, "NameRu" )
                                                                        : DataBinder.Eval(Container.DataItem, "Name" )
                                                                        %>
                                                                </h4>
                                                                <p class="foodContent">
                                                                    <%# System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="en"
                                                                        ?
                                                                        DataBinder.Eval(Container.DataItem, "DescriptionEn"
                                                                        ) :
                                                                        System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="ru"
                                                                        ?
                                                                        DataBinder.Eval(Container.DataItem, "DescriptionRu"
                                                                        ) :
                                                                        DataBinder.Eval(Container.DataItem, "Description"
                                                                        ) %>
                                                                </p>
                                                            </span>

                                                            <div class="foodPricing">
                                                                <%# (Eval("NewPrice").ToString())
                                                                    !=(Eval("OldPrice").ToString())
                                                                    ? "<span class='foodOldPrice'>EGP" +
                                                                    Convert.ToDecimal(Eval("OldPrice")).ToString("0.##")
                                                                    + "</span>" : "" %>
                                                                    <span class="foodNewPrice">
                                                                        <%# Convert.ToDecimal(Eval("NewPrice")).ToString("0.##")
                                                                            %>
                                                                            <%= Resources.Texts.Currency %>
                                                                    </span>
                                                            </div>
                                                        </div>

                                                        <span class="addToCart">
                                                            <span class="addToCartBtn"
                                                                title=<%=Resources.Texts.addtocart %>>
                                                                <i class="fa fa-plus-circle"></i>
                                                            </span>
                                                        </span>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>





                        </article>
                    </figure>



                    <article id="shoppingCart">
                        <div id="cartHolder">
                            <span id="closeCartBtn" class="close">&times;</span>

                            <h2 class="shoppingCartTitle">
                                <asp:Literal ID="ltShoppingCartTitle" runat="server"
                                    Text="<%$ Resources:texts, ShoppingCartTitle %>"></asp:Literal>
                            </h2>

                            <!-- Empty cart message -->
                            <figure id="emptyCart">
                                <i class="fa-solid fa-cart-shopping"></i>
                                <p>
                                    <asp:Literal ID="ltEmptyCart" runat="server"
                                        Text="<%$ Resources:texts, EmptyCartMessage %>"></asp:Literal>
                                </p>
                            </figure>

                            <!-- Cart items -->
                            <figure id="inCartItems">
                                <div class="preDeliveryFeeAmount">
                                    <p>
                                        <asp:Literal ID="ltSubtotal" runat="server"
                                            Text="<%$ Resources:texts, Subtotal %>"></asp:Literal>
                                    </p>
                                    <span class="subtotalAmount">0.00 ج.م</span>
                                </div>

                                <div class="deliveryAmount">
                                    <p>
                                        <asp:Literal ID="ltDeliveryFeeText" runat="server"
                                            Text="<%$ Resources:texts, DeliveryFee %>"></asp:Literal>
                                        <i class="fa-solid fa-circle-info"></i>
                                    </p>
                                    <span class="deliveryFee">0.00 ج.م</span>
                                </div>



                                <div class="afterDeliveryFeeAmount">
                                    <p>
                                        <asp:Literal ID="ltTotalAmountText" runat="server"
                                            Text="<%$ Resources:texts, TotalAmount %>"></asp:Literal>
                                    </p>
                                    <span class="totalAmount">0.00 ج.م</span>
                                </div>

                                <div class="confirmCartActions">
                                    <button class="submit" type="button">
                                        <a href="checkout.aspx">
                                            <asp:Literal ID="ltCheckout" runat="server"
                                                Text="<%$ Resources:texts, Checkout %>"></asp:Literal>
                                        </a>
                                    </button>
                                    <button type="button" id="emptyCartBtn"
                                        title='<asp:Literal ID="ltEmptyCartTitle" runat="server" Text="<%$ Resources:texts, EmptyCart %>" />'
                                        aria-label='<asp:Literal ID="ltEmptyCartAria" runat="server" Text="<%$ Resources:texts, EmptyCart %>" />'>
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </div>
                            </figure>
                        </div>
                    </article>

                </section>
            </div>
        </section>
        <div id="cartShower">
            <h3 id="totalPayAmount">
            </h3>
            <button type="button" class="submit">
                <asp:Literal ID="ltViewCart" runat="server" Text="<%$ Resources:texts, ViewCart %>"></asp:Literal>
            </button>
        </div>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="PageScripts" Runat="Server">

        <link href="css/css_web.css" rel="stylesheet" />



    </asp:Content>