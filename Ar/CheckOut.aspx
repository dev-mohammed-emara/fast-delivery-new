<%@ Page Title="" Language="C#" MasterPageFile="~/Ar/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="CheckOut.aspx.cs" Inherits="Ar_CheckOut" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" Runat="Server">
<asp:Literal ID="ltPageTitle" runat="server" Text="<%$ Resources:texts, CheckoutTitle %>" ></asp:Literal></asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="loader" class="loader-overlay">
       <div class="loader-box">
        <div class="spinner"></div>
        <asp:Literal ID="ltLoaderText" runat="server" Text="<%$ Resources:texts, LoaderText %>" />
    </div>
</div>

                    <style>
    /* Premium Checkout Styling */
    .checkoutDetails {
        padding-top: 130px;
        padding-bottom: 80px;
        padding-inline: 1rem;
        display: flex;
        justify-content: center;
        background-color: #f8f9fa; /* Slightly warmer gray */
    }

    .checkoutDetails .submit {
        margin: 0;
        padding: 0.85rem 2.5rem;
        max-width: fit-content;
        border-radius: 12px;
        font-weight: 700;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        background-color: var(--fd-blue);
        color: white;
        border: none;
        cursor: pointer;
        font-size: 1.05rem;
        box-shadow: 0 4px 10px rgba(255, 193, 25, 0.2);
    }

    .checkoutDetails .submit:hover {
        background-color: #e6b01a;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 193, 25, 0.4);
    }

    .checkoutContainer {
        max-width: 850px; /* More focused width */
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 2rem;
    }

    .checkoutBox {
        background: #ffffff;
        border-radius: 20px; /* More rounded */
        border: 1px solid rgba(0, 0, 0, 0.1);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
        display: flex;
        flex-direction: column;
        overflow: hidden;
        margin-bottom: 0.5rem;
    }

    .checkoutBoxTitle {
        display: flex;
        align-items: center;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        column-gap: 1.5rem;
        row-gap: 0.5rem;
        flex-wrap: wrap;
        justify-content: space-between;
        padding: 1.25rem 1.75rem;
        background-color: #fafafa;
    }

    .checkoutBoxTitle h2 {
        font-size: 1.25rem;
        margin: 0;
        font-weight: 800;
        color: #1a1a1a;
    }

    .checkoutBoxTitle a {
        color: var(--fd-blue);
        font-weight: 700;
        text-decoration: none;
        font-size: 0.95rem;
        padding: 0.5rem 1rem;
        background: rgba(255, 193, 25, 0.1);
        border-radius: 8px;
        transition: all 0.2s;
    }

    .checkoutBoxTitle a:hover {
        background: var(--fd-blue);
        color: white;
    }

    .orderInfo {
        display: flex;
        flex-direction: column;
        overflow-x: auto;
        gap: 0.5rem;
        padding: 1.5rem;
        -webkit-overflow-scrolling: touch;
    }

    /* Quantity Handlers Styles */
    .cartItemAmountHandlers, .cust-handlers {
        display: flex;
        align-items: center;
        justify-content: center;
        background: #f5f6f7;
        border-radius: 10px;
        padding: 4px;
        margin: 0 auto;
        width: fit-content;
        gap: 8px;
        border: 1px solid #eee;
        min-width: 100px;
    }

    .cartItemAmountHandlers button,
    .cust-handlers button {
        width: 28px;
        height: 28px;
        border-radius: 8px;
        border: none;
        background: white !important;
        color: var(--fd-blue) !important;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.2s;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        padding: 0 !important;
    }

    .cartItemAmountHandlers button:hover,
    .cust-handlers button:hover {
        background: var(--fd-blue) !important;
        color: white !important;
    }

    .itemAmount, .cust-qty-val {
        font-weight: 700;
        min-width: 20px;
        text-align: center;
        color: #333;
    }

    /* Delete Button Refined */
    .removeItem {
        width: 42px !important;
        height: 42px !important;
        border-radius: 12px !important;
        transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
        background-color: #fff5f5 !important;
        color: #ff4d4d !important;
        display: inline-flex !important;
        justify-content: center !important;
        align-items: center !important;
        cursor: pointer !important;
        border: 1px solid #ffebeb !important;
        margin: 0 auto !important;
    }

    .removeItem i {
        font-size: 1.15rem !important;
        margin: 0 !important;
    }

    .removeItem:hover {
        background-color: #ff4d4d !important;
        color: white !important;
        transform: rotate(8deg) scale(1.1);
        box-shadow: 0 4px 12px rgba(255, 77, 77, 0.25);
    }

    /* Grid for order items */
    .orderLabels,
    .orderStats {
        display: grid;
        grid-template-columns: 2.5fr 120px 1fr 1fr 0.5fr; /* Fixed width for handlers */
        padding-inline: 0.5rem;
        text-align: center;
        gap: 1rem;
        min-width: 750px;
        align-items: center;
    }

    .orderLabels span,
    .orderStats span {
        display: flex;
        flex-direction: column;
        line-height: 1.4;
        justify-content: center;
        padding: 1rem 0;
        white-space: nowrap;
    }

    .orderLabels {
        background-color: #f8f9fa;
        border-radius: 12px;
        margin-bottom: 0.75rem;
    }

    .orderLabels span {
        font-weight: 800;
        color: #999;
        font-size: 0.85rem;
        letter-spacing: 0.5px;
    }

    .orderStats {
        font-size: 1rem;
        border-bottom: 1px solid rgba(0, 0, 0, 0.03);
    }

    .orderStats:last-child {
        border-bottom: none;
    }

    .orderName {
        text-align: right !important;
        font-weight: 700;
        color: #333;
    }

    /* SUMMARY BOX OVERRIDE - Fixing the alignment */
    .totalAmountBox .orderStats {
        display: flex;
        justify-content: space-between;
        padding-inline: 1rem;
        min-width: unset;
        border-bottom: 1px dashed #eee;
    }

    .totalAmountBox .orderStats:last-child {
        border-bottom: none;
        background-color: #fcfcfc;
        border-radius: 10px;
        margin-top: 0.5rem;
    }

    .totalAmountBox .orderStats span {
        padding: 1rem 0;
        font-size: 1.1rem;
    }

    .totalAmountBox .orderStats span:first-child {
        font-weight: 600;
        color: #666;
    }

    .totalAmountBox .orderStats span:last-child {
        font-weight: 800;
        color: #000;
    }

    .totalAmountBox .checkoutBoxTitle h2 {
        color: var(--fd-blue);
    }

    /* Location Section */
    .checkoutLocation {
        padding: 1.5rem;
        background-color: white;
    }

    .checkoutSelectedLocation {
        line-height: 2;
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
    }

    .checkoutSelectedLocation p {
        margin: 0;
        color: #222;
        font-weight: 700;
        font-size: 1.05rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        flex-wrap: wrap;
    }

    .checkoutSelectedLocation p span {
        color: #777;
        font-weight: 400;
    }

    /* Payment Section */
    .paymentSection {
        padding: 2rem;
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    #discountWaring {
        display: flex;
        align-items: center;
        gap: 1.25rem;
        font-size: 1rem;
        padding: 1.25rem 1.75rem;
        background-color: #f4f6ff;
        border-radius: 16px;
        color: #444;
        border-right: 6px solid var(--fd-blue);
        box-shadow: 0 4px 12px rgba(255, 193, 25, 0.05);
    }

    #discountWaring i {
        font-size: 1.75rem;
        color: var(--fd-blue);
    }

    @media (max-width: 768px) {
        .checkoutDetails {
            padding-top: 110px;
            padding-inline: 1rem;
        }
        .orderLabels {
            display: grid;
        }
        .orderStats {
            grid-template-columns: 2.5fr 120px 1fr 1fr 0.5fr;
            text-align: center;
            gap: 1rem;
            padding: 1rem 0.5rem;
            min-width: 750px;
        }
        .orderName {
            grid-column: unset;
            font-size: 0.95rem;
        }
        .removeItem {
            grid-column: unset;
            width: 42px !important;
            height: 42px !important;
            margin-top: 0 !important;
        }
    }
    </style>




    <asp:HiddenField ID="hfAddId" runat="server" />
        <section class="checkoutDetails">
        <div class="checkoutContainer">
            <span class="route"> <a href="default.aspx"><asp:Literal ID="ltHome" runat="server" Text="<%$ Resources:texts, Home %>" /></a> <i class="fa-solid fa-angles-left"></i>
                <a href="./openedShopFoods.html"><span id="location"></span></a>
                <i class="fa-solid fa-angles-left"></i>  <asp:Literal ID="ltExecuteOrderRoute" runat="server" Text="<%$ Resources:texts, ExecuteOrder %>" />
        </span>
             <div id="checkoutCart">
            <article class="checkoutBox">
                <div class="checkoutBoxTitle">
                    <h2><asp:Literal ID="ltOrderDetailsTitle" runat="server" Text="<%$ Resources:texts, OrderDetailsTitle %>" /></h2>
                    <a href="shopPage.html"><asp:Literal ID="ltEditOrder" runat="server" Text="<%$ Resources:texts, EditOrder %>" /></a>
                </div>
                <div class="orderInfo">
                    <h3>هارت أتاك</h3>
                    <div class="orderLabels">
                        <span class="orderName"><asp:Literal ID="ltItem" runat="server" Text="<%$ Resources:texts, Item %>" /></span>
                        <span class="specialOrder"><asp:Literal ID="ltSpecialOrder" runat="server" Text="<%$ Resources:texts, SpecialOrder %>" /></span>
                        <span><asp:Literal ID="ltQuantity" runat="server" Text="<%$ Resources:texts, Quantity %>" /></span>
                        <span><asp:Literal ID="ltPrice" runat="server" Text="<%$ Resources:texts, Price %>" /></span>
                        <span><asp:Literal ID="ltTotal" runat="server" Text="<%$ Resources:texts, Total %>" /></span>
                    </div>
                    <div class="orderStats">
                        <span class="orderName">عرض كينج اتاك <span class="specialOrder">حار</span></span>
                        <span class="specialOrder"><asp:Literal ID="ltSpecialOrder2" runat="server" Text="<%$ Resources:texts, SpecialOrder %>" /></span>
                        <span>1</span>
                        <span>200.00 ج.م</span>
                        <span>200.00 ج.م</span>
                    </div>
                </div>
            </article>
        </div>

            <article class="checkoutBox">
            <div class="checkoutBoxTitle">
                <h2><asp:Literal ID="ltDeliveryAddress" runat="server" Text="<%$ Resources:texts, DeliveryAddress %>" /></h2>
                <div class="checkoutLocationBtns">
                    <button id="locbtn" class="submit" type="button">
                        <asp:Literal ID="ltAddEditAddress" runat="server" Text="<%$ Resources:texts, AddEditAddress %>" />
                    </button>
                </div>
            </div>
            <div class="checkoutLocation">
                <span id="emptyCheckoutLocation">
                    <asp:Literal ID="ltChooseDeliveryLocation" runat="server" Text="<%$ Resources:texts, ChooseDeliveryLocation %>" />
                </span>
                <div class="checkoutSelectedLocation">
                    <p class="card-text"><strong><asp:Literal ID="ltAddress" runat="server" Text="<%$ Resources:texts, Address %>" />:</strong><span id="AddName"></span></p>
                    <p class="card-text"><strong><asp:Literal ID="ltMobile" runat="server" Text="<%$ Resources:texts, Mobile %>" />:</strong><span id="mobile"></span></p>
                    <p class="card-text"><strong><asp:Literal ID="ltPhone" runat="server" Text="<%$ Resources:texts, Phone %>" />:</strong><span id="phone"></span></p>
                    <p class="card-text">
                        <strong><asp:Literal ID="ltStreet" runat="server" Text="<%$ Resources:texts, Street %>" />:</strong><span id="StreetName"></span>,
                        <strong><asp:Literal ID="ltBuilding" runat="server" Text="<%$ Resources:texts, Building %>" />:</strong><span id="Build"></span>,
                        <strong><asp:Literal ID="ltFloor" runat="server" Text="<%$ Resources:texts, Floor %>" />:</strong><span id="Floor"></span>,
                        <strong><asp:Literal ID="ltApartment" runat="server" Text="<%$ Resources:texts, Apartment %>" />:</strong><span id="AdepartmentNo"></span>
                    </p>
                    <p class="card-text"><strong><asp:Literal ID="ltGovernorate" runat="server" Text="<%$ Resources:texts, Governorate %>" />:</strong><span id="Gov"></span>,
                       <strong><asp:Literal ID="ltArea" runat="server" Text="<%$ Resources:texts, Area %>" />:</strong><span id="Area"></span></p>
                    <p class="card-text"><strong><asp:Literal ID="ltInstructions" runat="server" Text="<%$ Resources:texts, Instructions %>" />:</strong><span id="Instructions"></span></p>
                    <p class="card-text"><strong><asp:Literal ID="ltAddressType" runat="server" Text="<%$ Resources:texts, AddressType %>" />:</strong><span id="AType"></span></p>
                </div>
            </div>
        </article>
              <article class="checkoutBox" id="payForOrder">
            <div class="checkoutBoxTitle">
                <h2><asp:Literal ID="ltPaymentDetailsTitle" runat="server" Text="<%$ Resources:texts, PaymentDetailsTitle %>" /></h2>
            </div>
            <div class="paymentSection">
                <span id="discountWaring">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    <asp:Literal ID="ltPaymentWarning" runat="server" Text="<%$ Resources:texts, PaymentWarning %>" />
                </span>
                <button id="btnSaveStorage" type="button" class="submit">
                    <asp:Literal ID="ltExecuteOrderButton" runat="server" Text="<%$ Resources:texts, ExecuteOrder %>" />
                </button>
            </div>
        </article>

        </div>

    </section>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageScripts" Runat="Server">
                    <style>
    /* Premium Checkout Styling */
    .checkoutDetails {
        padding-top: 130px;
        padding-bottom: 80px;
        padding-inline: 1rem;
        display: flex;
        justify-content: center;
        background-color: #f8f9fa; /* Slightly warmer gray */
    }

    .checkoutDetails .submit {
        margin: 0;
        padding: 0.85rem 2.5rem;
        max-width: fit-content;
        border-radius: 12px;
        font-weight: 700;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        background-color: var(--fd-blue);
        color: white;
        border: none;
        cursor: pointer;
        font-size: 1.05rem;
        box-shadow: 0 4px 10px rgba(255, 193, 25, 0.2);
    }

    .checkoutDetails .submit:hover {
        background-color: #e6b01a;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 193, 25, 0.4);
    }

    .checkoutContainer {
        max-width: 850px; /* More focused width */
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 2rem;
    }

    .checkoutBox {
        background: #ffffff;
        border-radius: 20px; /* More rounded */
        border: 1px solid rgba(0, 0, 0, 0.1);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
        display: flex;
        flex-direction: column;
        overflow: hidden;
        margin-bottom: 0.5rem;
    }

    .checkoutBoxTitle {
        display: flex;
        align-items: center;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        column-gap: 1.5rem;
        row-gap: 0.5rem;
        flex-wrap: wrap;
        justify-content: space-between;
        padding: 1.25rem 1.75rem;
        background-color: #fafafa;
    }

    .checkoutBoxTitle h2 {
        font-size: 1.25rem;
        margin: 0;
        font-weight: 800;
        color: #1a1a1a;
    }

    .checkoutBoxTitle a {
        color: var(--fd-blue);
        font-weight: 700;
        text-decoration: none;
        font-size: 0.95rem;
        padding: 0.5rem 1rem;
        background: rgba(255, 193, 25, 0.1);
        border-radius: 8px;
        transition: all 0.2s;
    }

    .checkoutBoxTitle a:hover {
        background: var(--fd-blue);
        color: white;
    }

    .orderInfo {
        display: flex;
        flex-direction: column;
        overflow-x: auto;
        gap: 0.5rem;
        padding: 1.5rem;
        -webkit-overflow-scrolling: touch;
    }

    /* Quantity Handlers Styles */
    .cartItemAmountHandlers, .cust-handlers {
        display: flex;
        align-items: center;
        justify-content: center;
        background: #f5f6f7;
        border-radius: 10px;
        padding: 4px;
        margin: 0 auto;
        width: fit-content;
        gap: 8px;
        border: 1px solid #eee;
        min-width: 100px;
    }

    .cartItemAmountHandlers button,
    .cust-handlers button {
        width: 28px;
        height: 28px;
        border-radius: 8px;
        border: none;
        background: white !important;
        color: var(--fd-blue) !important;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.2s;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        padding: 0 !important;
    }

    .cartItemAmountHandlers button:hover,
    .cust-handlers button:hover {
        background: var(--fd-blue) !important;
        color: white !important;
    }

    .itemAmount, .cust-qty-val {
        font-weight: 700;
        min-width: 20px;
        text-align: center;
        color: #333;
    }

    /* Delete Button Refined */
    .removeItem {
        width: 42px !important;
        height: 42px !important;
        border-radius: 12px !important;
        transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
        background-color: #fff5f5 !important;
        color: #ff4d4d !important;
        display: inline-flex !important;
        justify-content: center !important;
        align-items: center !important;
        cursor: pointer !important;
        border: 1px solid #ffebeb !important;
        margin: 0 auto !important;
    }

    .removeItem i {
        font-size: 1.15rem !important;
        margin: 0 !important;
    }

    .removeItem:hover {
        background-color: #ff4d4d !important;
        color: white !important;
        transform: rotate(8deg) scale(1.1);
        box-shadow: 0 4px 12px rgba(255, 77, 77, 0.25);
    }

    /* Grid for order items */
    .orderLabels,
    .orderStats {
        display: grid;
        grid-template-columns: 2.5fr 120px 1fr 1fr 0.5fr; /* Fixed width for handlers */
        padding-inline: 0.5rem;
        text-align: center;
        gap: 1rem;
        min-width: 750px;
        align-items: center;
    }

    .orderLabels span,
    .orderStats span {
        display: flex;
        flex-direction: column;
        line-height: 1.4;
        justify-content: center;
        padding: 1rem 0;
        white-space: nowrap;
    }

    .orderLabels {
        background-color: #f8f9fa;
        border-radius: 12px;
        margin-bottom: 0.75rem;
    }

    .orderLabels span {
        font-weight: 800;
        color: #999;
        font-size: 0.85rem;
        letter-spacing: 0.5px;
    }

    .orderStats {
        font-size: 1rem;
        border-bottom: 1px solid rgba(0, 0, 0, 0.03);
    }

    .orderStats:last-child {
        border-bottom: none;
    }

    .orderName {
        text-align: right !important;
        font-weight: 700;
        color: #333;
    }

    /* SUMMARY BOX OVERRIDE - Fixing the alignment */
    .totalAmountBox .orderStats {
        display: flex;
        justify-content: space-between;
        padding-inline: 1rem;
        min-width: unset;
        border-bottom: 1px dashed #eee;
    }

    .totalAmountBox .orderStats:last-child {
        border-bottom: none;
        background-color: #fcfcfc;
        border-radius: 10px;
        margin-top: 0.5rem;
    }

    .totalAmountBox .orderStats span {
        padding: 1rem 0;
        font-size: 1.1rem;
    }

    .totalAmountBox .orderStats span:first-child {
        font-weight: 600;
        color: #666;
    }

    .totalAmountBox .orderStats span:last-child {
        font-weight: 800;
        color: #000;
    }

    .totalAmountBox .checkoutBoxTitle h2 {
        color: var(--fd-blue);
    }

    /* Location Section */
    .checkoutLocation {
        padding: 1.5rem;
        background-color: white;
    }

    .checkoutSelectedLocation {
        line-height: 2;
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
    }

    .checkoutSelectedLocation p {
        margin: 0;
        color: #222;
        font-weight: 700;
        font-size: 1.05rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        flex-wrap: wrap;
    }

    .checkoutSelectedLocation p span {
        color: #777;
        font-weight: 400;
    }

    /* Payment Section */
    .paymentSection {
        padding: 2rem;
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    #discountWaring {
        display: flex;
        align-items: center;
        gap: 1.25rem;
        font-size: 1rem;
        padding: 1.25rem 1.75rem;
        background-color: #f4f6ff;
        border-radius: 16px;
        color: #444;
        border-right: 6px solid var(--fd-blue);
        box-shadow: 0 4px 12px rgba(255, 193, 25, 0.05);
    }

    #discountWaring i {
        font-size: 1.75rem;
        color: var(--fd-blue);
    }

    @media (max-width: 768px) {
        .checkoutDetails {
            padding-top: 110px;
            padding-inline: 1rem;
        }
        .orderLabels {
            display: grid;
        }
        .orderStats {
            grid-template-columns: 2.5fr 120px 1fr 1fr 0.5fr;
            text-align: center;
            gap: 1rem;
            padding: 1rem 0.5rem;
            min-width: 750px;
        }
        .orderName {
            grid-column: unset;
            font-size: 0.95rem;
        }
        .removeItem {
            grid-column: unset;
            width: 42px !important;
            height: 42px !important;
            margin-top: 0 !important;
        }
    }
    </style>




     <link href="css/css_web.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>

        document.getElementById('btnSaveStorage').addEventListener('click', function () {

            let data = localStorage.getItem("cartItems");
            let raw = document.getElementById("Deliverycost").textContent;

            // تنظيف الرقم
            raw = raw.replace(/[^\d.]/g, "");
            raw = raw.replace(/\.$/, "");
            let deliveryCost = raw.trim();

            if (!data) {
                Swal.fire({
                    title: "السلة فارغة",
                    icon: "warning"
                });
                return;
            }
            $("#loader").css("display", "flex");
            let saveUrl = '<%= ResolveUrl("~/Ar/SaveLocalStorage.aspx/SaveLocalStorage") %>';
            fetch(saveUrl, {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=utf-8" },
                body: JSON.stringify({
                    cart: data,
                    action: "update",
                    id: 1,
                    deliveryCost: deliveryCost
                })
            })
            .then(res => res.json())
            .then(result => {
                if (result.d.success) {
                    localStorage.removeItem("cartItems");
                    $("#loader").hide();
                    Swal.fire({
                        title: "تم ارسال طلبكم بنجاح فى انتظار التنفيذ",
                        text: result.d.Message || "",
                        icon: "success",
                        confirmButtonText: "متابعة"
                    }).then(sw => {
                        if (sw.isConfirmed) {
                            window.location.href = "POrders.aspx";
                        }
                    });

                } else {
                    $("#loader").hide();
                    Swal.fire({
                        title: "خطأ",
                        text: result.d.error,
                        icon: "error"
                    });
                    console.error("Error:", result.d.error);
                }
            })
            .catch(err => {
                $("#loader").hide();
                console.error(err);
                Swal.fire({
                    title: "خطأ في الاتصال",
                    text: "حدثت مشكلة أثناء تنفيذ العملية",
                    icon: "error"
                });
            });
        });

</script>
    <script>
        document.getElementById('locbtn').addEventListener('click', function () {
    // هنا حط رابط الصفحة اللي عايز تظهرها
    document.getElementById('locationIframe').src = 'AddAddress.aspx';
    var myModal = new bootstrap.Modal(document.getElementById('locationModal'));
    myModal.show();
});
</script>
    <div class="modal fade" id="locationModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">اختر موقعك</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body p-2">
        <iframe id="locationIframe" src="AddAddress.aspx"
                style="width:100%; height:85dvh; min-height: 500px; border:none; -webkit-overflow-scrolling: touch;"></iframe>
      </div>
    </div>
  </div>
</div>

    <script>
var locationModal = document.getElementById('locationModal');

locationModal.addEventListener('hidden.bs.modal', function () {
    // يعيد تحميل الصفحة
    location.reload();
});
</script>

</asp:Content>





