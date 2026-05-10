<%@ Page Title="" Language="C#" MasterPageFile="~/Ar/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="CheckOut.aspx.cs" Inherits="Ar_CheckOut" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" Runat="Server">
<asp:Literal ID="ltPageTitle" runat="server" Text="<%$ Resources:texts, CheckoutTitle %>" ></asp:Literal></asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<!-- <div id="loader" class="loader-overlay">
       <div class="loader-box">
        <div class="spinner"></div>
        <asp:Literal ID="ltLoaderText" runat="server" Text="<%$ Resources:texts, LoaderText %>" />
    </div>
</div> -->

                    <style>
    /* Premium Checkout Styling */
    .checkoutDetails {
        padding-top: 130px;
        padding-bottom: 50px;
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
        margin-bottom: 1.25rem;
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
        h2{
            display: flex;
            align-items: center;
            gap: 8px;
        }
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
        padding: 0 !important;
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
        transform: rotate(2deg) scale(1.1);
        box-shadow: 0 4px 12px rgba(255, 77, 77, 0.25);
    }

    /* Grid for order items */
    .orderLabels,
    .orderStats {
        display: grid;
        grid-template-columns: 3fr 120px 1fr 1fr 0.5fr; /* Name, Quantity, Price, Total, Remove */
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
            grid-template-columns: 3fr 120px 1fr 1fr 0.5fr;
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

    .green-success-box {
        width: 100%;
        margin-bottom: 16px;
        padding: 10px 12px;
        background-color: #f6fff9;
        border: 1px solid #c3e6cb;
        border-radius: 8px;
        color: #155724;
        font-size: 0.82rem;
        line-height: 1.5;
        font-weight: 500;
        text-align: right;
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
                        <span><asp:Literal ID="ltQuantity" runat="server" Text="<%$ Resources:texts, Quantity %>" /></span>
                        <span><asp:Literal ID="ltPrice" runat="server" Text="<%$ Resources:texts, Price %>" /></span>
                        <span><asp:Literal ID="ltTotal" runat="server" Text="<%$ Resources:texts, Total %>" /></span>
                        <span></span>
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
                <h2><i class="fa-solid fa-map-location-dot"></i> <asp:Literal ID="ltDeliveryAddress" runat="server" Text="<%$ Resources:texts, DeliveryAddress %>" /></h2>
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
                <h2><i class="fa-solid fa-comment-dollar"></i> <asp:Literal ID="ltPaymentDetailsTitle" runat="server" Text="<%$ Resources:texts, PaymentDetailsTitle %>" /></h2>
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
        padding-bottom: 50px;
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
        margin-bottom: 1.25rem;
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
            grid-template-columns: 3fr 120px 1fr 1fr 0.5fr;
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
        /* Promo & Payment Sections */

    .promo-header-wrap {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        flex-wrap: wrap;
        gap: 10px;
    }
    .promo-modes {
        display: flex;
        background: #f8f9fa;
        padding: 4px;
        border-radius: 12px;
        border: 1px solid #eee;
    }
    .promo-mode-btn {
        padding: 6px 12px;
        font-size: 0.8rem;
        font-weight: 600;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.2s;
        border: none;
        background: transparent;
        color: #666;
    }
   
    .promo-mode-btn.active {
        background: var(--fd-blue);
        color:  white;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    .promo-input-wrap {
        display: flex;
        gap: 10px;
        margin-top: 15px;
    }
    .promo-input-wrap input {
        flex: 1;
        padding: 0.85rem 1.25rem;
        border: 1.5px solid #eee;
        border-radius: 12px;
        font-size: 0.95rem;
        outline: none;
        transition: border-color 0.2s;
    }
    .promo-input-wrap input:focus {
        border-color: var(--fd-blue);
    }
    .promo-input-wrap .apply-btn {
        padding: 0 20px;
        border-radius: 12px;
        background: #28a745;
        color: white;
        font-weight: 700;
        border: none;
        cursor: pointer;
        transition: all 0.2s;
    }
    .promo-input-wrap .apply-btn.remove {
        background: #dc3545;
    }
    .promo-clarification {
        font-size: 0.8rem;
        color: #888;
        margin-top: 8px;
        display: block;
        width: 100%;
        font-weight: 500;
        padding-inline: 4px;
    }
    .promo-msg {
        margin: 12px 0 0;
        padding: 10px 15px;
        font-size: 0.85rem;
        font-weight: 600;
        border-radius: 8px;
        display: none;
    }
    .promo-msg.success {
        color: #2f855a;
        background: #f0fff4;
        border-inline-start: 4px solid #48bb78;
    }
    .promo-msg.error {
        color: #c53030;
        background: #fff5f5;
        border-inline-start: 4px solid #f56565;
    }

    .pay-options-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
        gap: 10px;
        margin-top: 5px;
    }
    .pay-option {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 1.25rem 0.5rem;
        border-radius: 15px;
        border: 2px solid #f0f0f0;
        cursor: pointer;
        transition: all 0.2s;
        background: white;
        text-align: center;
        position: relative;
    }
    .pay-option input {
        position: absolute;
        opacity: 0;
    }
    .pay-option i, .pay-option svg, .pay-option img {
        font-size: 1.5rem;
        transition: all 0.2s;
    }
    .pay-option .fa-hand-holding-dollar { color: #28a745; } /* Cash Green */
    .pay-option .fa-credit-card { color: #0056b3; }       /* Visa Blue */
    .pay-option .fa-mobile-screen-button { color: #e91e63; } /* InstaPay Pink */
    .pay-option .fa-wallet { color: #fd7e14; }             /* Wallet Orange */

    .pay-option:not(.selected) i,
    .pay-option:not(.selected) svg {
        opacity: 0.8;
    }
    .pay-option span {
        font-size: 0.85rem;
        font-weight: 700;
        color: #444;
    }
    .pay-option:hover {
        border-color: var(--fd-blue);
        background: rgba(255, 193, 25, 0.03);
    }
    .pay-option.selected {
        border-color: var(--fd-blue);
        background: rgba(255, 193, 25, 0.08);
    }
    .pay-option.selected i, .pay-option.selected svg {
        color: var(--fd-blue);
    }
    .pay-option.selected span {
        color: var(--fd-blue);
    }

    #paymentProofWrap {
        margin-top: 1.25rem;
        padding: 1.25rem;
        background: #fff9eb;
        border: 1.5px dashed var(--fd-blue);
        border-radius: 15px;
        display: flex;
        flex-direction: column;
        gap: 12px;
    }
    .proof-label {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 0.85rem;
        font-weight: 700;
        color: #5d4037;
    }
    .proof-input {
        padding: 0.75rem 1rem;
        border: 1.5px solid #e0e0e0;
        border-radius: 10px;
        width: 100%;
        font-size: 0.9rem;
        background: white;
    }
    .proof-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        padding: 0.85rem;
        background: white;
        border: 2px solid var(--fd-blue);
        color: var(--fd-blue);
        border-radius: 12px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.2s;
        width: 100%;
    }
    .proof-btn:hover {
        background: var(--fd-blue);
        color: white;
    }
    #paymentProofPreview {
        width: 100%;
        max-height: 200px;
        object-fit: contain;
        border-radius: 10px;
        background: #eee;
        margin-top: 5px;
        border: 1px solid #ddd;
    }

    @media (max-width: 480px) {
        .pay-options-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    /* Vendor Order Types (Delivery/Pickup) */
    .vendor-group-types {
        display: flex;
        gap: 10px;
        margin-bottom: 12px;
        padding: 0 1rem;
    }
    .order-type-opt {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 16px 10px;
        border-radius: 12px;
        border: 2px solid #eee;
        background: white;
        color: #666;
        cursor: pointer;
        font-weight: 700;
        font-size: 0.85rem;
        transition: all 0.2s;
    }
    .order-type-opt i {
        font-size: 1rem;
    }
    .order-type-opt.active {
        background: var(--fd-blue);
        color: white;
        border-color: var(--fd-blue);
    }
    .pickup-warning {
        margin: 5px 1rem 15px;
        padding: 10px 15px;
        background: #fff5f5;
        border-inline-start: 4px solid #ff4d4d;
        border-radius: 8px;
        font-size: 0.8rem;
        font-weight: 600;
        color: #c53030;
        display: none;
    }
    .promo-info-box {
        margin: 12px 0;
        padding: 10px 15px;
        background: #ebf8ff;
        border-inline-start: 4px solid #4299e1;
        border-radius: 8px;
        font-size: 0.85rem;
        font-weight: 600;
        color: #2b6cb0;
        display: block;
    }
    .vendor-group-footer {
        display: flex;
        flex-direction: column;
        gap: 8px;
        padding: 1rem;
        background: #fafafa;
        border-top: 1px dashed #eee;
        border-radius: 0 0 16px 16px;
    }
    .vendor-group-footer span {
        display: flex;
        justify-content: space-between;
        font-size: 0.9rem;
        color: #555;
    }
    .vendor-group-footer span strong {
        color: #000;
        font-weight: 800;
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

        // --- Payment & Promo Functions ---
        window.selectedPromoMode = 'order';

        window.setPromoMode = function(mode, btn) {
            window.selectedPromoMode = mode;
            document.querySelectorAll('.promo-mode-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            const input = document.getElementById('promoInput');
            if (mode === 'shipping') {
                input.placeholder = texts.ShippingDiscountPlaceholder;
            } else {
                input.placeholder = texts.OrderDiscountPlaceholder;
            }
        };

        window.currentDiscount = 0;
        window.currentDiscountType = 'order'; // 'order' or 'shipping'

        window.applyPromo = function() {
            const codeInput = document.getElementById('promoInput');
            const applyBtn = document.querySelector('.promo-input-wrap .apply-btn');
            const msgEl = document.getElementById('promoMsg');
            const summaryMsgEl = document.getElementById('promoSummaryMsg');

            if (!msgEl || !applyBtn) return;

            // If a coupon is already applied, clicking should remove it
            if (window.currentDiscount > 0) {
                window.currentDiscount = 0;
                window.currentDiscountType = 'order';
                codeInput.value = '';
                applyBtn.textContent = texts.Apply;
                applyBtn.classList.remove('remove');
                msgEl.style.display = 'none';
                if (summaryMsgEl) summaryMsgEl.style.display = 'none';

                if (typeof updateGlobalDeliveryCost === 'function') updateGlobalDeliveryCost();
                return;
            }

            const code = codeInput.value.trim();
            if (!code) {
                msgEl.textContent = texts.EnterPromoCodeError;
                msgEl.className = "promo-msg error";
                msgEl.style.display = 'block';
                return;
            }

            // Simulated "Database"
            const validCodes = [
                { code: '123456', type: 'order', percentage: 20 },
                { code: '7890', type: 'shipping', percentage: 20 }
            ];

            const modeLabel = window.selectedPromoMode === 'shipping' ? texts.ShippingDiscount : texts.OrderDiscount;
            msgEl.textContent = `${texts.CheckingPromo} ${modeLabel}...`;
            msgEl.className = "promo-msg";
            msgEl.style.display = 'block';

            setTimeout(() => {
                const found = validCodes.find(c => c.code === code && c.type === window.selectedPromoMode);

                if (found) {
                    const subtotalEl = document.querySelector(".totalAmountBox .subtotal-row span:last-child");
                    const subtotal = parseFloat(subtotalEl?.innerText.replace(/[^\d.]/g, '')) || 0;
                    const deliveryEl = document.getElementById("Deliverycost");
                    const delivery = parseFloat(deliveryEl?.innerText.replace(/[^\d.]/g, '')) || 0;

                    let discountAmount = 0;
                    if (found.type === 'shipping') {
                        discountAmount = delivery * (found.percentage / 100);
                        window.currentDiscountType = 'shipping';
                    } else {
                        discountAmount = subtotal * (found.percentage / 100);
                        window.currentDiscountType = 'order';
                    }

                    window.currentDiscount = discountAmount;

                    const successTitle = texts.PromoAppliedSuccess.replace('{0}', modeLabel);
                    const savedText = texts.PromoSavedAmount.replace('{0}', discountAmount.toFixed(2)).replace('{1}', texts.Currency).replace('{2}', found.percentage);

                    msgEl.innerHTML = `✅ <strong>${successTitle}</strong><br><small>${savedText}</small>`;
                    msgEl.className = "promo-msg success";
                    msgEl.style.display = 'block';

                    // Update Button State
                    applyBtn.textContent = texts.RemoveCoupon;
                    applyBtn.classList.add('remove');

                    if (summaryMsgEl) {
                        const summaryText = texts.PromoSummaryApplied
                            .replace('{0}', discountAmount.toFixed(2))
                            .replace('{1}', texts.Currency)
                            .replace('{2}', found.percentage)
                            .replace('{3}', found.type === 'shipping' ? texts.ShippingDiscount : texts.OrderDiscount);
                        summaryMsgEl.innerHTML = `<i class="fa-solid fa-tag"></i> ${summaryText}`;
                        summaryMsgEl.style.display = 'block';
                    }

                    if (typeof updateGlobalDeliveryCost === 'function') updateGlobalDeliveryCost();
                } else {
                    msgEl.innerHTML = `❌ ${texts.PromoErrorInvalid}`;
                    msgEl.className = "promo-msg error";
                    msgEl.style.display = 'block';
                    window.currentDiscount = 0;
                    if (summaryMsgEl) summaryMsgEl.style.display = 'none';
                    if (typeof updateGlobalDeliveryCost === 'function') updateGlobalDeliveryCost();
                }
            }, 800);
        };

        window.selectPayment = function(el, method) {
            document.querySelectorAll('.pay-option').forEach(opt => opt.classList.remove('selected'));
            el.classList.add('selected');
            el.querySelector('input').checked = true;

            const proofWrap = document.getElementById('paymentProofWrap');
            if (method === 'cash' || method === 'visa') {
                proofWrap.style.display = 'none';
            } else {
                proofWrap.style.display = 'flex';
            }
        };

        window.previewPaymentProof = function(input) {
            const preview = document.getElementById('paymentProofPreview');
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            }
        };

        window.setVendorOrderType = function(vendorId, type) {
            const container = document.querySelector(`.vendor-group-types[data-vendor="${vendorId}"]`);
            if(!container) return;
            const btns = container.querySelectorAll('.order-type-opt');
            btns.forEach(btn => {
                if (btn.getAttribute('data-type') === type) {
                    btn.classList.add('active');
                } else {
                    btn.classList.remove('active');
                }
            });

            const msg = document.getElementById(`pickupMsg-${vendorId}`);
            const shopDeliveryEl = document.getElementById(`shopDelivery-${vendorId}`);
            const footer = document.querySelector(`.vendor-group-footer[data-vendor="${vendorId}"]`);

            if (msg) {
                if (type === 'pickup') {
                    msg.style.display = 'block';
                    if(shopDeliveryEl) shopDeliveryEl.innerHTML = `<strong>0 ${texts.Currency || 'ج.م'}</strong>`;
                } else {
                    msg.style.display = 'none';
                    const originalFee = footer ? footer.getAttribute('data-delivery-fee') : '0';
                    if(shopDeliveryEl) shopDeliveryEl.innerHTML = `<strong>${originalFee} ${texts.Currency || 'ج.م'}</strong>`;
                }
            }

            // Sync with global delivery cost
            updateGlobalDeliveryCost();
        };

        function updateGlobalDeliveryCost() {
            let totalDelivery = 0;
            let anyPickup = false;

            document.querySelectorAll('.vendor-group-types').forEach(group => {
                const activeBtn = group.querySelector('.order-type-opt.active');
                if (activeBtn && activeBtn.getAttribute('data-type') === 'pickup') {
                    anyPickup = true;
                }
            });

            document.querySelectorAll('.vendor-group-footer').forEach(footer => {
                const amountSpan = footer.querySelector('.shop-delivery-fee strong');
                if (amountSpan) {
                    const price = parseFloat(amountSpan.innerText.replace(/[^\d.]/g, '')) || 0;
                    totalDelivery += price;
                }
            });

            const globalDeliveryEl = document.getElementById("Deliverycost");
            if (globalDeliveryEl) {
                globalDeliveryEl.innerText = `${totalDelivery} ${texts.Currency || 'ج.م'}`;
            }

            // Update Final Total
            const subtotalEl = document.querySelector(".totalAmountBox .subtotal-row span:last-child");
            const finalTotalEl = document.querySelector(".totalAmountBox .final-total-row span:last-child");

            if (subtotalEl && finalTotalEl) {
                const subtotal = parseFloat(subtotalEl.innerText.replace(/[^\d.]/g, '')) || 0;
                const discount = window.currentDiscount || 0;
                const newTotal = (subtotal + totalDelivery) - discount;
                finalTotalEl.innerText = `${newTotal.toLocaleString()} ${texts.Currency || 'ج.م'}`;
            }

            // Show/Hide Pickup Message
            const pickupMsg = document.getElementById("pickupSummaryMsg");
            if (pickupMsg) {
                pickupMsg.style.display = anyPickup ? "block" : "none";
            }
        }
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
        <h5 class="modal-title" data-text="ChooseLocation">اختر موقعك</h5>
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





