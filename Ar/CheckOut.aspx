<%@ Page Title="" Language="C#" MasterPageFile="~/Ar/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="CheckOut.aspx.cs" Inherits="Ar_CheckOut" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" Runat="Server">
    <title><asp:Literal ID="ltPageTitle" runat="server" Text="<%$ Resources:texts, CheckoutTitle %>" ></asp:Literal></title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
    #rescheduleBtn{
        display: flex;
        white-space: nowrap;
        align-items: center;
        gap: 8px;
    }

    .checkoutDetails .submit {
        margin: 0;
        padding: 0.5rem 2.5rem;
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
        gap: 0.5rem;
        padding: 1rem;
        overflow-x: hidden;
    }

    /* Hide the old labels row - compact layout is self-describing */
    .orderLabels {
        display: none !important;
    }

    /* Compact card layout for each checkout item */
    .orderStats.checkout-main-item-row {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        gap: 0.5rem;
        padding: 0.75rem 0.5rem;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        min-width: unset;
    }

    .orderStats.checkout-main-item-row .orderedItemMain.orderName {
        flex: 1 1 100%;
        text-align: start !important;
        font-weight: 700;
        color: #333;
        flex-direction: row;
        gap: 1rem;
        justify-content: space-between;
        margin-bottom: 0.25rem;
    }

    .orderStats.checkout-main-item-row .orderedItemName {
        font-size: 0.95rem;
        white-space: normal;
        word-break: break-word;
    }

    .orderStats.checkout-main-item-row .checkout-item-size {
        color: #888;
        font-weight: 600;
    }

    .orderStats.checkout-main-item-row .unit-price {
        color: #999;
        font-size: 0.8rem;
    }

    /* Quantity Handlers Styles */
    .cartItemAmountHandlers, .cust-handlers {
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        padding: 4px;
        width: fit-content;
        gap: 8px;
    }

    .cartItemAmountHandlers button,
    .cust-handlers button {
        width: 26px;
        height: 26px;
        border-radius: 8px;
        border: none;
        color: white !important;
        background: var(--fd-blue) !important;
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
        font-size: 1rem;
        text-align: center;
        color: #333;
    }

    /* Price shown in the bottom row */
    .orderStats.checkout-main-item-row .totalItemPrice {
        margin-inline-start: auto;
        font-weight: 800;
        color: #e65100;
        font-size: 1rem;
        white-space: nowrap;
    }

    /* Hide the unit price column - already shown in name */
    .orderStats.checkout-main-item-row .itemPrice {
        display: none;
    }

    /* Delete Button Refined */
    .removeItem {
        width: 34px !important;
        height: 34px !important;
        border-radius: 10px !important;
        transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
        background-color: #fff5f5 !important;
        color: #ff4d4d !important;
        display: inline-flex !important;
        padding: 0 !important;
        justify-content: center !important;
        align-items: center !important;
        cursor: pointer !important;
        border: 1px solid #ffebeb !important;
        flex-shrink: 0;
    }

    .removeItem i {
        font-size: 0.9rem !important;
        margin: 0 !important;
    }

    .removeItem:hover {
        transform: rotate(2deg) scale(1.1);
        box-shadow: 0 4px 12px rgba(255, 77, 77, 0.25);
    }

    /* Customization addon rows */
    .checkout-customization-row,
    .checkout-upsell-row {
        display: flex !important;
        flex-wrap: wrap;
        align-items: center;
        gap: 0.5rem;
        padding: 0.35rem 0.5rem 0.35rem 1.5rem;
        min-width: unset !important;
        font-size: 0.85rem;
        color: #666;
        border-bottom: 1px dashed rgba(0,0,0,0.04);
    }

    .checkout-customization-row .orderName,
    .checkout-upsell-row .orderName {
        flex: 1;
        text-align: start !important;
    }

    .checkout-customization-row .itemPrice,
    .checkout-upsell-row .itemPrice {
        display: none;
    }

    .checkout-customization-row .itemTotal,
    .checkout-upsell-row .itemTotal {
        font-weight: 700;
        color: var(--fd-blue);
        margin-inline-start: auto;
        white-space: nowrap;
    }

    .checkout-customization-row .removeItem,
    .checkout-upsell-row .removeItem {
        width: 26px !important;
        height: 26px !important;
    }

    /* Checkout group total */
    .checkout-group-total {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.5rem 0.5rem;
        background: #f8f9fa;
        border-radius: 8px;
        margin-top: 0.25rem;
        font-size: 0.9rem;
    }

    .checkout-group-total .group-total-label {
        font-weight: 600;
        color: #666;
    }

    .checkout-group-total .group-total-amount {
        font-weight: 800;
        color: #e65100;
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


    @media (max-width: 480px) {
        .paymentSection {
            padding: 1rem !important;
        }
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

    /* Utility & Component Classes for Inline Style Removal */
    .orange-legend {
        width: auto;
        padding: 0 10px;
        font-size: 1rem;
        font-weight: 700;
        color: #ff6b00;
        float: inline-start;
    }

    .grid-2-col {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 10px;
    }

    .grid-2-col-card {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 10px;
        margin-top: 10px;
        background: #fdfdfd;
        padding: 10px;
        border-radius: 8px;
    }

    .mt-10 { margin-top: 10px; }
    .mt-15 { margin-top: 15px; }
    .mb-0 { margin-bottom: 0; }

    .contact-section {
        margin-top: 15px;
        background: #f9f9f9;
        padding: 12px;
        border-radius: 8px;
        border: 2px dashed rgba(0, 0, 0, 0.05);
    }

    .contact-section-title {
        font-size: 0.9rem;
        font-weight: bold;
        color: #ff6b00;
        margin-bottom: 1rem;
    }

    .contact-methods {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 0.75rem;
    }

    .icon-sm {
        font-size: 1.2rem;
        margin-bottom: 5px;
    }

    .text-xs {
        font-size: 0.8rem;
    }

    .delivery-time-fieldset {
        margin-top: 15px;
        border: 1px solid #eee;
        border-radius: 8px;
        padding: 15px;
        background: #fff;
    }

    .delivery-time-display {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 10px;
    }

    .hint-text {
        font-size: 0.9rem;
        font-weight: 700;
        color: #ff6b00;
        display: block;
        margin-top: 5px;
    }

    .flex-gap-8 {
        display: flex;
        gap: 8px;
    }

    .btn-reschedule {
        padding: 6px 12px;
        font-size: 0.85rem;
        background: #ffc119;
        color: white;
        min-width: auto;
        height: auto;
    }

    .btn-reset {
        padding: 6px 12px;
        font-size: 0.85rem;
        background: #eee;
        color: white;
        min-width: auto;
        height: auto;
    }

    /* Summary Section Classes */
    .summary-container {
        padding: 1rem;
        border-top: 1px dashed #eee;
    }
    .summary-fieldset {
        border: 2px dashed #eee;
        border-radius: 12px;
        padding: 15px;
        background: #fff;
    }
    .summary-line {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 8px;
    }
    .summary-label {
        font-weight: 600;
        color: #666;
    }
    .summary-value {
        font-size: 1.1rem;
        color: #000;
    }
    .summary-total-line {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-top: 1px solid #eee;
        padding-top: 10px;
        margin-top: 5px;
    }
    .summary-total-label {
        font-weight: 800;
        color: #000;
        font-size: 1.2rem;
    }
    .summary-total-value {
        font-size: 1.4rem;
        color: var(--fd-blue);
    }
    .flex-col {
        display: flex;
        flex-direction: column;
    }
    .m-10-1rem { margin: 10px 1rem; }
    .m-10-1rem-15 { margin: 10px 1rem 15px; }
    .promo-summary-box {
        margin: 10px 0;
        font-size: 0.85rem;
        padding: 8px 12px;
        border-radius: 8px;
    }
    .multi-shop-alert-banner {
        display: flex;
        align-items: center;
        gap: 12px;
        background: #fff8eb;
        border: 1.5px solid #ffe8cc;
        border-radius: 12px;
        padding: 12px 16px;
        margin-bottom: 15px;
        color: #b25e00;
        font-size: 0.9rem;
        font-weight: 600;
        box-shadow: 0 2px 6px rgba(178, 94, 0, 0.05);
    }
    .multi-shop-alert-banner i {
        font-size: 1.2rem;
        color: #e8590c;
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
                    <h3><asp:Literal ID="ltLoadingOrder" runat="server" Text="<%$ Resources:texts, LoadingOrder %>" /></h3>
                    <div class="orderLabels">
                        <span class="orderName"><asp:Literal ID="ltItemLabel" runat="server" Text="<%$ Resources:texts, Item %>" /></span>
                        <span><asp:Literal ID="ltQuantityLabel" runat="server" Text="<%$ Resources:texts, Quantity %>" /></span>
                        <span><asp:Literal ID="ltPriceLabel" runat="server" Text="<%$ Resources:texts, Price %>" /></span>
                        <span><asp:Literal ID="ltTotalLabel" runat="server" Text="<%$ Resources:texts, Total %>" /></span>
                        <span></span>
                    </div>
                    <div id="cartItemsContainer">
                        </div>
                </div>
            </article>
        </div>


        <article class="checkoutBox promo-section">
        <div class="checkoutBoxTitle">
            <h2><i class="fa-solid fa-ticket"></i> <asp:Literal ID="ltPromoCodeTitle" runat="server" Text="<%$ Resources:texts, PromoCode %>" /></h2>
        </div>
        <div class="paymentSection promo-dual-container">
            <div class="promo-field-group" id="orderPromoGroup">
                <label class="promo-field-label"><i class="fa-solid fa-bag-shopping"></i> <asp:Literal runat="server" Text="<%$ Resources:texts, OrderDiscount %>" /></label>
                <div class="promo-input-wrap" id="orderPromoInputWrap">
                    <input type="text" id="promoInputOrder" placeholder="<%= GetGlobalResourceObject("texts", "EnterPromoCode") %>" class="auth-input" onkeydown="if(event.key === 'Enter') { applyPromo('order'); event.preventDefault(); }">
                    <button type="button" onclick="applyPromo('order')" id="applyBtnOrder" class="apply-btn"><asp:Literal runat="server" Text="<%$ Resources:texts, Apply %>" /></button>
                </div>
                <p class="promo-msg" id="promoMsgOrder" style="display:none;"></p>
                <div id="orderPromoDisabledMsg" class="promo-msg error" style="display:none; background-color: #fff0f0; border: 1px solid #ffc9c9; color: #e03131; padding: 8px 12px; border-radius: 8px; font-size: 0.85rem; font-weight: bold; margin-top: 5px; display: flex; align-items: center; gap: 8px;"></div>
            </div>

            <div class="promo-field-group" id="shippingPromoGroup">
                <label class="promo-field-label"><i class="fa-solid fa-truck"></i> <asp:Literal runat="server" Text="<%$ Resources:texts, ShippingDiscount %>" /></label>
                <div class="promo-input-wrap">
                    <input type="text" id="promoInputShipping" placeholder="<%= GetGlobalResourceObject("texts", "EnterPromoCode") %>" class="auth-input" onkeydown="if(event.key === 'Enter') { applyPromo('shipping'); event.preventDefault(); }">
                    <button type="button" onclick="applyPromo('shipping')" id="applyBtnShipping" class="apply-btn"><asp:Literal runat="server" Text="<%$ Resources:texts, Apply %>" /></button>
                </div>
                <p class="promo-msg" id="promoMsgShipping" style="display:none;"></p>
            </div>

            <div class="promo-info-box">
                <asp:Literal ID="ltPromoInfo" runat="server" Text="<%$ Resources:texts, PromoInfo %>" />
            </div>
        </div>
    </article>


    <article class="checkoutBox global-delivery-section">
        <div class="checkoutBoxTitle">
            <h2><i class="fa-solid fa-truck-fast"></i> <asp:Literal ID="ltDeliveryMethod" runat="server" Text="<%$ Resources:texts, DeliveryMethod %>" /></h2>
        </div>
        <div class="vendor-group-types global-types">
            <button type="button" class="order-type-opt active" data-type="delivery" onclick="setGlobalOrderType('delivery')">
                <i class="fa-solid fa-motorcycle"></i> <asp:Literal ID="ltDelivery" runat="server" Text="<%$ Resources:texts, Delivery %>" />
            </button>
            <button type="button" class="order-type-opt" data-type="pickup" onclick="setGlobalOrderType('pickup')">
                <i class="fa-solid fa-store"></i> <asp:Literal ID="ltPickup" runat="server" Text="<%$ Resources:texts, Pickup %>" />
            </button>
            <button type="button" class="order-type-opt" data-type="in-shop" onclick="setGlobalOrderType('in-shop')">
                <i class="fa-solid fa-utensils"></i> <asp:Literal ID="ltInShop" runat="server" Text="<%$ Resources:texts, InShop %>" />
            </button>
        </div>
        <div id="globalAreaDiscountMsg" class="promo-msg success m-10-1rem" style="display:none;">
            </div>
        <div class="global-delivery-summary summary-container">
            <fieldset class="summary-fieldset">

                <div class="summary-line" style="align-items: flex-start;">
                    <div style="display: flex; gap:1rem;">
                        <span class="summary-label"><asp:Literal ID="ltDeliveryFeeLabel" runat="server" Text="<%$ Resources:texts, DeliveryFeeLabel %>" /></span>
                        <span id="firstOrderDeliveryMsg" class="promo-msg success" style="display: none; padding: 4px 8px; margin: 4px 0 0; font-size: 0.75rem; border-radius: 4px; border-inline-start: 2px solid #48bb78; line-height: 1.3;"></span>
                    </div>
                    <strong id="globalTotalDelivery" class="summary-value">0 <asp:Literal ID="ltCurrency1" runat="server" Text="<%$ Resources:texts, Currency %>" /></strong>
                </div>
                <div class="summary-line">
                    <span class="summary-label"><asp:Literal ID="ltSubtotalLabel" runat="server" Text="<%$ Resources:texts, SubtotalLabel %>" /></span>
                    <strong id="globalSubtotal" class="summary-value">0 <asp:Literal ID="ltCurrency2" runat="server" Text="<%$ Resources:texts, Currency %>" /></strong>
                </div>
                <div class="summary-line">
                    <span class="summary-label summary-label-time"><asp:Literal ID="ltTotalDeliveryTimeLabel" runat="server" Text="<%$ Resources:texts, TotalDeliveryTime %>" /></span>
                    <strong id="globalTotalDeliveryTime" class="summary-value">0 <asp:Literal ID="ltMinutesSummary" runat="server" Text="<%$ Resources:texts, Minutes %>" /></strong>
                </div>
                <div id="promoSummaryMsg" class="promo-msg success promo-summary-box" style="display:none;">
                    </div>
                <div class="summary-total-line">
                    <div class="flex-col">
                        <span class="summary-total-label"><asp:Literal ID="ltFinalTotalLabel" runat="server" Text="<%$ Resources:texts, FinalTotalLabel %>" /></span>
                        <small id="globalPromoBadge" style="color: #28a745; font-weight: 700; display: none;"></small>
                    </div>
                    <strong id="globalFinalTotal" class="summary-total-value">0 <asp:Literal ID="ltCurrency3" runat="server" Text="<%$ Resources:texts, Currency %>" /></strong>
                </div>
            </fieldset>
            <span id="Deliverycost" style="display:none;">0</span>
        </div>
        <div id="globalPickupMsg" class="pickup-warning m-10-1rem-15">
            <asp:Literal ID="ltPickupWarning" runat="server" Text="<%$ Resources:texts, PickupWarning %>" />
        </div>
    </article>


    <article class="checkoutBox payment-method-section">
        <div class="checkoutBoxTitle">
            <h2><i class="fa-solid fa-hand-holding-dollar"></i> <asp:Literal ID="ltPaymentMethodTitle" runat="server" Text="<%$ Resources:texts, PaymentMethod %>" /></h2>
        </div>
        <div class="paymentSection">
            <div class="pay-options-grid">
                <label class="pay-option selected pay-cash" onclick="selectPayment(this, 'cash')">
                    <input type="radio" name="payMethod" value="cash" checked="">
                    <i class="fa-solid fa-money-bill-1-wave"></i>
                    <span><asp:Literal ID="ltCash" runat="server" Text="<%$ Resources:texts, Cash %>" /></span>
                </label>
                <label class="pay-option pay-visa" onclick="selectPayment(this, 'visa')">
                    <input type="radio" name="payMethod" value="visa">
                    <i class="fa-solid fa-credit-card"></i>
                    <span><asp:Literal ID="ltVisa" runat="server" Text="<%$ Resources:texts, Visa %>" /></span>
                </label>
                <label class="pay-option pay-instapay" onclick="selectPayment(this, 'instapay')">
                    <input type="radio" name="payMethod" value="instapay">
                    <img src="images/instapay.webp" alt="InstaPay" style="width: 35px; height: 35px; object-fit: contain; margin-bottom: 5px;">
                    <span>InstaPay</span>
                </label>
                <label class="pay-option pay-wallet" onclick="selectPayment(this, 'wallet')">
                    <input type="radio" name="payMethod" value="wallet">
                    <i class="fa-solid fa-wallet"></i>
                    <span><asp:Literal ID="ltWallet" runat="server" Text="<%$ Resources:texts, Wallet %>" /></span>
                </label>
                <label class="pay-option pay-vodafone" onclick="selectPayment(this, 'vodafone_cash')">
                    <input type="radio" name="payMethod" value="vodafone_cash">
                    <img src="images/vodafon.png" alt="Vodafone Cash" style="width: 35px; height: 35px; object-fit: contain; margin-bottom: 5px;">
                    <span><asp:Literal ID="ltVodafoneCash" runat="server" Text="<%$ Resources:texts, VodafoneCash %>" /></span>
                </label>
            </div>
            <div id="paymentProofWrap" style="display:none;">
                <label class="proof-label"><i class="fa-solid fa-phone"></i> <asp:Literal ID="ltPayerPhone" runat="server" Text="<%$ Resources:texts, PayerPhone %>" /></label>
                <input type="tel" id="payerPhone" class="proof-input" placeholder="01xxxxxxxxx" dir="ltr">

                <label class="proof-label"><i class="fa-solid fa-image"></i> <asp:Literal ID="ltPaymentProofImage" runat="server" Text="<%$ Resources:texts, PaymentProofImage %>" /></label>
                <button type="button" class="proof-btn" onclick="document.getElementById('paymentProofFile').click()">
                    <i class="fa-solid fa-cloud-arrow-up"></i> <asp:Literal ID="ltAttachProof" runat="server" Text="<%$ Resources:texts, AttachProof %>" />
                </button>
                <input type="file" id="paymentProofFile" accept="image/*" onchange="previewPaymentProof(this)" style="display:none;">
                <img id="paymentProofPreview" style="display:none;">
            </div>
        </div>
    </article>

            <article class="checkoutBox">
            <div class="checkoutBoxTitle">
                <h2><i class="fa-solid fa-map-location-dot"></i> <asp:Literal ID="ltAddressDetailsTitle" runat="server" Text="<%$ Resources:texts, Address %>" /></h2>
                <div class="checkoutLocationBtns">
                    <button id="locbtn" class="submit" type="button">
                        <asp:Literal ID="ltAddEditAddressBtn" runat="server" Text="<%$ Resources:texts, AddEditAddressBtn %>" />
                    </button>
                </div>
            </div>
            <div class="checkoutLocation">

                <fieldset class="checkoutSelectedLocation" >
                    <legend class="orange-legend"><asp:Literal ID="ltSelectedDeliveryInfo" runat="server" Text="<%$ Resources:texts, SelectedDeliveryInfo %>" /></legend>
                    <p class="card-text"><strong><asp:Literal ID="ltAddressLabel" runat="server" Text="<%$ Resources:texts, Address %>" />:</strong> <span id="AddName"></span></p>
                    <div class="grid-2-col">
                        <p class="card-text"><strong><asp:Literal ID="ltMobileLabel" runat="server" Text="<%$ Resources:texts, Mobile %>" />:</strong> <span id="mobile"></span></p>
                        <p class="card-text"><strong><asp:Literal ID="ltPhoneLabel" runat="server" Text="<%$ Resources:texts, Phone %>" />:</strong> <span id="phone"></span></p>
                    </div>
                    <div class="grid-2-col-card">
                        <p class="card-text"><strong><asp:Literal ID="ltStreetLabel" runat="server" Text="<%$ Resources:texts, Street %>" />:</strong> <span id="StreetName"></span></p>
                        <p class="card-text"><strong><asp:Literal ID="ltBuildingLabel" runat="server" Text="<%$ Resources:texts, Building %>" />:</strong> <span id="Build"></span></p>
                        <p class="card-text"><strong><asp:Literal ID="ltFloorLabel" runat="server" Text="<%$ Resources:texts, Floor %>" />:</strong> <span id="Floor"></span></p>
                        <p class="card-text"><strong><asp:Literal ID="ltApartmentLabel" runat="server" Text="<%$ Resources:texts, Apartment %>" />:</strong> <span id="AdepartmentNo"></span></p>
                    </div>
                    <p class="card-text mt-10"><strong><asp:Literal ID="ltGovernorateLabel" runat="server" Text="<%$ Resources:texts, Governorate %>" />:</strong> <span id="Gov"></span> - <strong><asp:Literal ID="ltAreaLabel" runat="server" Text="<%$ Resources:texts, Area %>" />:</strong> <span id="Area"></span></p>
                    <p class="card-text"><strong><asp:Literal ID="ltInstructionsLabel" runat="server" Text="<%$ Resources:texts, Instructions %>" />:</strong> <span id="Instructions"></span></p>
                    <p class="card-text"><strong><asp:Literal ID="ltAddressTypeLabel" runat="server" Text="<%$ Resources:texts, AddressType %>" />:</strong> <span id="AType"></span></p>

                    <div id="contactMethodSection" class="contact-section">
                        <p class="contact-section-title">
                            <i class="fa-solid fa-headset"></i> <asp:Literal ID="ltContactMethodTitle" runat="server" Text="<%$ Resources:texts, ContactMethodTitle %>" />
                        </p>
                        <div class="pay-options contact-methods">
                            <label class="pay-option selected contact-phone" data-method="phone" id="contact-method-1" onclick="selectContactMethod(this, 'phone')">
                                <i class="fa-solid fa-phone icon-sm"></i>
                                <span class="text-xs"><asp:Literal ID="ltCallPhone" runat="server" Text="<%$ Resources:texts, CallPhone %>" /></span>
                            </label>
                            <label class="pay-option contact-whatsapp" data-method="whatsapp" id="contact-method-2" onclick="selectContactMethod(this, 'whatsapp')">
                                <i class="fa-brands fa-whatsapp icon-sm"></i>
                                <span class="text-xs"><asp:Literal ID="ltWhatsApp" runat="server" Text="<%$ Resources:texts, WhatsApp %>" /></span>
                            </label>
                            <label class="pay-option contact-bell" data-method="ring_bell" id="contact-method-3" onclick="selectContactMethod(this, 'ring_bell')">
                                <i class="fa-solid fa-bell icon-sm"></i>
                                <span class="text-xs"><asp:Literal ID="ltRingBell" runat="server" Text="<%$ Resources:texts, RingBell %>" /></span>
                            </label>
                        </div>
                    </div>

                    <fieldset class="checkoutDeliveryTime delivery-time-fieldset">

                        <div id="deliveryTimeDisplay" class="delivery-time-display">
                            <div>
                                <p class="card-text mb-0">
                                    <strong id="deliveryTimeLabel"><asp:Literal ID="ltExpectedDeliveryTime" runat="server" Text="<%$ Resources:texts, ExpectedDeliveryTime %>" />:</strong>
                                    <span id="scheduledTime">--:--</span>
                                </p>
                                <small id="deliveryTimeHint" class="hint-text">
                                    <i class="fa-regular fa-clock"></i> </small>
                            </div>
                             <div class="flex-gap-8">
                                <button id="rescheduleBtn" class="submit btn-reschedule" type="button">
                                    <i class="fa-solid fa-calendar-day"></i> <asp:Literal ID="ltRescheduleBtn" runat="server" Text="<%$ Resources:texts, RescheduleBtn %>" />
                                </button>
                                <button id="resetScheduledBtn" class="submit btn-reset" type="button" style="display: none;">
                                    <i class="fa-solid fa-rotate-left"></i> <asp:Literal ID="ltResetBtn" runat="server" Text="<%$ Resources:texts, Reset %>" />
                                </button>
                             </div>
                        </div>
                        <input type="text" id="deliveryTimePicker" style="display: none;">
                    </fieldset>
                </fieldset>
            </div>
        </article>

              <article class="checkoutBox" id="payForOrder">
            <div class="checkoutBoxTitle">
                <h2><i class="fa-solid fa-comment-dollar"></i> <asp:Literal ID="ltPaymentDetailsTitle" runat="server" Text="<%$ Resources:texts, PaymentDetailsTitle %>" /></h2>
            </div>
            <div class="paymentSection">
                <div class="order-live-summary">
                <div class="summary-item">
                    <span class="label"><i class="fa-solid fa-credit-card"></i> <asp:Literal ID="ltLivePayTitle" runat="server" Text="<%$ Resources:texts, PaymentMethod %>" />:</span>
                    <strong id="live-payment">-</strong>
                </div>
                <div class="summary-item">
                    <span class="label"><i class="fa-solid fa-truck-fast"></i> <span id="live-del-label-span"><asp:Literal ID="ltLiveDelTitle" runat="server" Text="<%$ Resources:texts, DeliveryMethod %>" /></span>:</span>
                    <strong id="live-delivery">-</strong>
                </div>
                <div class="summary-item" id="live-contact-wrap">
                    <span class="label"><i class="fa-solid fa-headset"></i> <asp:Literal ID="ltLiveContactTitle" runat="server" Text="<%$ Resources:texts, ContactMethodTitle %>" />:</span>
                    <strong id="live-contact">-</strong>
                </div>
                <div class="summary-item" id="live-coupon-wrap-order" style="display:none;">
                    <span class="label"><i class="fa-solid fa-tag"></i> <asp:Literal ID="ltLiveCouponTitleOrder" runat="server" Text="<%$ Resources:texts, OrderDiscount %>" />:</span>
                    <strong id="live-coupon-order" class="success-text">-</strong>
                </div>
                <div class="summary-item" id="live-coupon-wrap-shipping" style="display:none;">
                    <span class="label"><i class="fa-solid fa-tag"></i> <asp:Literal ID="ltLiveCouponTitleShipping" runat="server" Text="<%$ Resources:texts, ShippingDiscount %>" />:</span>
                    <strong id="live-coupon-shipping" class="success-text">-</strong>
                </div>
                <div class="summary-item" id="live-time-wrap" style="display:none;">
                    <span class="label"><i class="fa-solid fa-calendar-check"></i> <asp:Literal ID="ltLiveTimeTitle" runat="server" Text="<%$ Resources:texts, DeliveryTimeTitle %>" />:</span>
                    <strong id="live-time">-</strong>
                </div>
            </div>

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
        padding: 0.5rem 2.5rem;
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
        border-radius: 10px;
        padding: 4px;
        margin: 0 auto;
        width: fit-content;
        gap: 8px;
        min-width: 100px;
    }

    .cartItemAmountHandlers button,
    .cust-handlers button {
        width: 26px;
        height: 26px;
        border-radius: 8px;
        border: none;
        color: white !important;
        background: var(--fd-blue) !important;
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
        text-align: center;
        font-size: 1rem;
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



    /* Compact card layout - duplicated in PageScripts for full coverage */
    .orderLabels {
        display: none !important;
    }

    .orderStats.checkout-main-item-row {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        gap: 0.5rem;
        padding: 0.75rem 0.5rem;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        min-width: unset;
    }

    .orderStats.checkout-main-item-row .orderedItemMain.orderName {
        flex: 1 1 100%;
        text-align: start !important;
        font-weight: 700;
        color: #333;
        margin-bottom: 0.25rem;
    }

    .orderStats.checkout-main-item-row .totalItemPrice {
        margin-inline-start: auto;
        font-weight: 800;
        color: #e65100;
        font-size: 1rem;
        white-space: nowrap;
    }

    .orderStats.checkout-main-item-row .itemPrice {
        display: none;
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

    .checkoutSelectedLocation p:not(.checkoutSelectedLocation p) {
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

    .order-live-summary {
        background: #f0f7ff;
        border-radius: 12px;
        padding: 1rem;
        margin-bottom: 0.5rem;
        border: 1px solid #e1effe;
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .order-live-summary .summary-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 0.95rem;
        color: #4b5563;
    }

    .order-live-summary .summary-item .label {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 500;
    }

    .order-live-summary .summary-item .label i {
        color: var(--fd-blue);
        width: 18px;
        text-align: center;
    }

    .order-live-summary .summary-item strong {
        color: #1f2937;
        font-weight: 700;
        white-space: nowrap;
    }

    .order-live-summary .summary-item .success-text {
        color: #059669;
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
            padding-inline: 0.5rem;
        }
        .orderInfo {
            padding: 0.75rem;
        }
    }

    @media (max-width:480px) {
         .checkoutDetails {
            padding-top: 50px;
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

    .promo-dual-container {
        display: flex;
        flex-direction: column;
        gap: 1.2rem;
    }
    .promo-field-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }
    .promo-field-label {
        font-size: 0.9rem;
        font-weight: 700;
        color: #444;
        display: flex;
        align-items: center;
        gap: 6px;
    }
    .promo-input-wrap {
        display: flex;
        gap: 10px;
        margin-top: 5px;
    }
    .promo-input-wrap input {
        flex: 1;
        padding: 0.85rem 1.25rem;
        border: 1.5px solid #eee;
        border-radius: 12px;
        font-size: 0.95rem;
        width: 100%;
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
        margin-bottom: 4px;
    }

    /* Distinct Colors for Options */
    .pay-option.pay-cash { border-color: #e8f5e9; background: #fafdff; }
    .pay-option.pay-cash i { color: #28a745; }

    .pay-option.pay-visa { border-color: #e3f2fd; background: #fafdff; }
    .pay-option.pay-visa i { color: #0056b3; }

    .pay-option.pay-instapay { border-color: #fce4ec; background: #fafdff; }
    .pay-option.pay-instapay i { color: #e91e63; }

    .pay-option.pay-wallet { border-color: #fff3e0; background: #fafdff; }
    .pay-option.pay-wallet i { color: #fd7e14; }

    .pay-option.pay-vodafone { border-color: #ffebee; background: #fafdff; }
    .pay-option.pay-vodafone i { color: #e60000; }

    .pay-option.contact-bell { border-color: #f3e5f5; background: #fafdff; }
    .pay-option.contact-bell i { color: #7e57c2; }

    .pay-option.contact-whatsapp { border-color: #e8f5e9; background: #fafdff; }
    .pay-option.contact-whatsapp i { color: #25D366; }

    .pay-option.contact-phone { border-color: #e1f5fe; background: #fafdff; }
    .pay-option.contact-phone i { color: #03a9f4; }

    .pay-option:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        border-color: var(--fd-blue);
    }

    .pay-option.selected {
        border-color: var(--fd-blue);
        background: rgba(255, 193, 25, 0.08);
        box-shadow: 0 8px 20px rgba(255, 193, 25, 0.15);
    }
    .pay-option.selected i, .pay-option.selected span {
        color: var(--fd-blue) !important;
    }

    .pay-option span {
        font-size: 0.85rem;
        font-weight: 700;
        color: #444;
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
        flex-wrap: wrap;
        gap: 10px;
        padding:  1rem;
    }
    .order-type-opt {
        flex: 1;
        display: flex;
        align-items: center;
        white-space: nowrap;
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

        document.getElementById('btnSaveStorage').addEventListener('click', async function () {

            let data = localStorage.getItem("cartItems");
            let raw = document.getElementById("Deliverycost").textContent;

            // تنظيف الرقم
            raw = raw.replace(/[^\d.]/g, "");
            raw = raw.replace(/\.$/, "");
            let deliveryCost = raw.trim();

            const state = (window.cart && window.cart.checkoutState) ? window.cart.checkoutState : {};
            const paymentMethod = state.paymentMethod || 'cash';
            const scheduledTime = state.scheduledTime || '';
            const activeOrderType = state.deliveryMethod || 'delivery';
            const isPickup = activeOrderType === 'pickup' || activeOrderType === 'in-shop';
            const contactMethod = state.contactMethod || 'phone';

            let payerPhone = "";
            let paymentProofBase64 = "";

            if (['instapay', 'wallet', 'vodafone_cash'].includes(paymentMethod)) {
                payerPhone = document.getElementById('payerPhone') ? document.getElementById('payerPhone').value : "";
                if (!payerPhone && state.payerPhone) payerPhone = state.payerPhone;

                const fileInput = document.getElementById('paymentProofFile');

                const txts = window.texts || {};
                if (fileInput && fileInput.files && fileInput.files.length > 0) {
                    const file = fileInput.files[0];
                    if (!file.type.startsWith('image/')) {
                         Swal.fire({
                            title: txts.FileErrorTitle || "خطأ في الملف",
                            text: txts.FileErrorText || "يرجى اختيار ملف صورة صحيح",
                            icon: "error"
                        });
                        return;
                    }
                    paymentProofBase64 = await toBase64(file);
                    // Update state
                    if (window.cart) {
                        window.cart.checkoutState.paymentProofBase64 = paymentProofBase64;
                        window.cart.checkoutState.payerPhone = payerPhone;
                        window.cart.saveCheckoutState();
                    }
                } else {
                    // Fallback to state if already uploaded
                    paymentProofBase64 = state.paymentProofBase64 || "";
                }

                if (!paymentProofBase64) {
                    Swal.fire({
                        title: txts.ProofRequiredTitle || "مطلوب إثبات الدفع",
                        text: txts.ProofRequiredText || "يرجى إرفاق صورة إثبات الدفع (سكرين شوت التحويل)",
                        icon: "error"
                    });
                    return;
                }

                if (!payerPhone) {
                    Swal.fire({
                        title: txts.PhoneRequiredTitle || "مطلوب رقم الهاتف",
                        text: txts.PhoneRequiredText || "يرجى إدخال رقم الهاتف الذي تم التحويل منه",
                        icon: "error"
                    });
                    return;
                }
            }

            if (typeof updateLiveSummary === 'function') updateLiveSummary();

            if (!data) {
                const txts = window.texts || {};
                Swal.fire({
                    title: txts.EmptyCartTitle || "السلة فارغة",
                    icon: "warning"
                });
                return;
            }

            // Map cart items to guarantee they contain proofbase64, phone, customization, and notes columns with values or null
            let itemsArr = [];
            try {
                itemsArr = JSON.parse(data) || [];
            } catch (e) {
                itemsArr = [];
            }

            itemsArr = itemsArr.map(item => {
                let custVal = null;
                if (item.customization !== undefined && item.customization !== null) {
                    custVal = item.customization;
                }

                let notesVal = null;
                if (item.notes !== undefined && item.notes !== null && item.notes !== "") {
                    notesVal = item.notes;
                } else if (item.customization && item.customization.notes !== undefined && item.customization.notes !== null && item.customization.notes !== "") {
                    notesVal = item.customization.notes;
                }

                const actualProof = paymentProofBase64 ? paymentProofBase64 : null;
                const actualPhone = payerPhone ? payerPhone : null;

                return {
                    ...item,
                    proofbase64: actualProof,
                    phone: actualPhone,
                    phoneNumber: actualPhone,
                    phone_number: actualPhone,
                    customization: custVal,
                    notes: notesVal
                };
            });

            data = JSON.stringify(itemsArr);

            // Safe mapping function to ensure null is sent instead of undefined or empty string
            const safeVal = (v) => (v === undefined || v === null || v === "" || v === "undefined") ? null : v;

            let finalScheduledTime = null;
            if (scheduledTime) {
                const cleanTime = scheduledTime.trim();
                const isNow = !cleanTime || cleanTime.includes('الآن') || cleanTime.includes('Now');
                if (!isNow) {
                    finalScheduledTime = cleanTime;
                }
            }

            const finalContactMethod = isPickup ? null : contactMethod;

            const orderCoupon = (window.promoOrder && window.promoOrder.code) ? window.promoOrder.code : null;
            const deliveryCoupon = (window.promoShipping && window.promoShipping.code) ? window.promoShipping.code : null;

            const totalCostEl = document.getElementById("globalFinalTotal");
            let totalCost = null;
            if (totalCostEl) {
                const parsed = parseFloat(totalCostEl.textContent.replace(/[^\d.]/g, ""));
                totalCost = isNaN(parsed) ? null : parsed;
            }

            const payload = {
                cart: safeVal(data),
                action: "update",
                id: 1,
                deliveryCost: safeVal(deliveryCost),
                paymentMethod: safeVal(paymentMethod),
                scheduledTime: safeVal(finalScheduledTime),
                contactMethod: safeVal(finalContactMethod),
                orderType: safeVal(activeOrderType),
                payerPhone: safeVal(payerPhone),

                // Extra explicit fields requested by the user
                totalCost: safeVal(totalCost),
                orderCoupon: safeVal(orderCoupon),
                deliveryCoupon: safeVal(deliveryCoupon),

                // Arabic equivalents as requested explicitly
                "طريقة الاستلام": safeVal(activeOrderType),
                "إجمالي الدفع": safeVal(totalCost),
                "طريقة التواصل مع المندوب": safeVal(finalContactMethod),
                "المجدول": safeVal(finalScheduledTime),
                "كوبون الطلب": safeVal(orderCoupon),
                "كوبون التوصيل": safeVal(deliveryCoupon)
            };

            // Parse cart payload to clean object representation for the alert
            let formattedCart = [];
            try {
                formattedCart = JSON.parse(payload.cart) || [];
            } catch(e) {
                formattedCart = payload.cart;
            }

            const alertPayload = {
                ...payload,
                cart: formattedCart
            };

            alert(JSON.stringify(alertPayload, null, 2));

            $("#loader").css("display", "flex");
            let saveUrl = '<%= ResolveUrl("~/Ar/SaveLocalStorage.aspx/SaveLocalStorage") %>';
            fetch(saveUrl, {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=utf-8" },
                body: JSON.stringify(payload)
            })
            .then(res => res.json())
            .then(result => {
                const txts = window.texts || {};
                if (result.d.success) {
                    localStorage.removeItem("cartItems");
                    $("#loader").hide();
                    Swal.fire({
                        title: txts.OrderSuccessTitle || "تم ارسال طلبكم بنجاح فى انتظار التنفيذ",
                        text: result.d.Message || "",
                        icon: "success",
                        confirmButtonText: txts.ContinueBtn || "متابعة"
                    }).then(sw => {
                        if (sw.isConfirmed) {
                            window.location.href = "POrders.aspx";
                        }
                    });

                } else {
                    $("#loader").hide();
                    Swal.fire({
                        title: txts.ErrorTitle || "خطأ",
                        text: result.d.error,
                        icon: "error"
                    });
                    console.error("Error:", result.d.error);
                }
            })
            .catch(err => {
                $("#loader").hide();
                console.error(err);
                const txts = window.texts || {};
                Swal.fire({
                    title: txts.ConnectionErrorTitle || "خطأ في الاتصال",
                    text: txts.ConnectionErrorText || "حدثت مشكلة أثناء تنفيذ العملية",
                    icon: "error"
                });
            });
        });

        // --- Payment & Promo Functions ---

        window.updateLiveSummary = function() {
            const texts = window.texts || {};
            let state = {};
            if (window.cart && window.cart.checkoutState) {
                state = window.cart.checkoutState;
            } else {
                try {
                    state = JSON.parse(localStorage.getItem("checkoutState")) || {};
                } catch(e) {}
            }
            if (!state.paymentMethod) state.paymentMethod = 'cash';
            if (!state.contactMethod) state.contactMethod = 'phone';
            if (!state.deliveryMethod) state.deliveryMethod = 'delivery';

            // 1. Payment Method
            const payVal = state.paymentMethod || 'cash';

            // ربط وتلوين كلاس الزر النشط في الرسوميات وتفعيل الـ Radio برمجياً
            document.querySelectorAll('.pay-options-grid .pay-option').forEach(opt => opt.classList.remove('selected'));
            const currentPayBtn = document.querySelector(`.pay-option.pay-${payVal.replace('_', '')}`) ||
                                 document.querySelector(`.pay-option[onclick*="'${payVal}'"]`);
            if (currentPayBtn) {
                currentPayBtn.classList.add('selected');
                const radio = currentPayBtn.querySelector('input');
                if (radio) radio.checked = true;
            }

            const payLabelMap = {
                'cash': texts.Cash || 'نقدي',
                'visa': texts.Visa || 'فيزا / ماستر كارد',
                'instapay': 'InstaPay',
                'wallet': texts.EWallet || 'المحفظة الإلكترونية',
                'vodafone_cash': texts.VodafoneCash || 'فودافون كاش'
            };
            const livePay = document.getElementById('live-payment');
            if (livePay) livePay.textContent = payLabelMap[payVal] || payVal;

            // 2. Delivery Method
            const activeType = state.deliveryMethod || 'delivery';
            const isPickup = activeType === 'pickup' || activeType === 'in-shop';
            const liveDel = document.getElementById('live-delivery');
            const delLabelSpan = document.getElementById('live-del-label-span');
            if (delLabelSpan) {
                if (activeType === 'in-shop' || activeType === 'pickup') {
                    delLabelSpan.innerText = texts.PickupMethodTitle || 'طريقة الاستلام';
                } else {
                    delLabelSpan.innerText = texts.DeliveryMethodTitle || 'طريقة التوصيل';
                }
            }
            if (liveDel) {
                if (activeType === 'in-shop') {
                    liveDel.textContent = texts.EatInShop || 'طلب في المحل';
                } else {
                    liveDel.textContent = isPickup ? (texts.PickupFromStore || 'استلام من الفرع') : (texts.HomeDelivery || 'توصيل للمنزل');
                }
            }

            // 3. Contact Method
            const contactWrap = document.getElementById('live-contact-wrap');
            if (contactWrap) {
                contactWrap.style.display = isPickup ? 'none' : 'flex';
                const contactVal = state.contactMethod || 'phone';

                // ربط وتلوين كلاس الزر النشط في الرسوميات للمندوب
                document.querySelectorAll('.contact-methods .pay-option').forEach(opt => opt.classList.remove('selected'));
                const currentContactBtn = document.querySelector(`.contact-methods .pay-option[data-method="${contactVal}"]`) ||
                                         document.querySelector(`.contact-methods .pay-option.contact-${contactVal.replace('_', '')}`) ||
                                         document.querySelector(`.contact-methods .pay-option[onclick*="'${contactVal}'"]`);
                if (currentContactBtn) {
                    currentContactBtn.classList.add('selected');
                }

                const contactLabelMap = {
                    'phone': texts.CallPhone || 'مكالمة هاتفية',
                    'whatsapp': texts.WhatsApp || 'واتساب',
                    'ring_bell': texts.RingBell || 'يرن الجرس'
                };
                const liveContact = document.getElementById('live-contact');
                if (liveContact) liveContact.textContent = contactLabelMap[contactVal] || contactVal;
            }

            // 4. Coupons (Order & Shipping)
            const orderCouponWrap = document.getElementById('live-coupon-wrap-order');
            if (orderCouponWrap) {
                if (window.promoOrder?.code) {
                    orderCouponWrap.style.display = 'flex';
                    const liveCouponOrder = document.getElementById('live-coupon-order');
                    if (liveCouponOrder) liveCouponOrder.textContent = window.promoOrder.code + ' ' + (texts.Applied || '(تم التطبيق)');
                } else {
                    orderCouponWrap.style.display = 'none';
                }
            }

            const shippingCouponWrap = document.getElementById('live-coupon-wrap-shipping');
            if (shippingCouponWrap) {
                // Also hide shipping coupon if in pickup/in-shop mode
                if (window.promoShipping?.code && !isPickup) {
                    shippingCouponWrap.style.display = 'flex';
                    const liveCouponShipping = document.getElementById('live-coupon-shipping');
                    if (liveCouponShipping) liveCouponShipping.textContent = window.promoShipping.code + ' ' + (texts.Applied || '(تم التطبيق)');
                } else {
                    shippingCouponWrap.style.display = 'none';
                }
            }

            // 5. Scheduled Time
            const timeWrap = document.getElementById('live-time-wrap');
            if (timeWrap) {
                const schedTime = state.scheduledTime || '';
                // Check if it's NOT "Now" (either Arabic or English)
                const isNow = !schedTime || schedTime.includes('الآن') || schedTime.includes('Now');
                if (!isNow) {
                    timeWrap.style.display = 'flex';
                    const liveTime = document.getElementById('live-time');
                    if (liveTime) liveTime.textContent = schedTime;
                } else {
                    timeWrap.style.display = 'none';
                }
            }
        };

        document.addEventListener('DOMContentLoaded', function() {
            let state = {};
            try {
                state = JSON.parse(localStorage.getItem("checkoutState")) || {};
            } catch(e) {}

            // Ensure defaults are present in our local variable and localStorage
            let changed = false;
            if (!state.paymentMethod) {
                state.paymentMethod = 'cash';
                changed = true;
            }
            if (!state.contactMethod || !state.contactMethodMigrated) {
                state.contactMethod = 'phone';
                state.contactMethodMigrated = true;
                changed = true;
            }
            if (!state.deliveryMethod) {
                state.deliveryMethod = 'delivery';
                changed = true;
            }
            if (changed) {
                localStorage.setItem("checkoutState", JSON.stringify(state));
            }

            if (window.cart) {
                window.cart.checkoutState = state;
            }

            // Sync Delivery Type
            setGlobalOrderType(state.deliveryMethod || 'delivery');

            // تشغيل الملخص الرسومي فوراً
            if (typeof updateLiveSummary === 'function') updateLiveSummary();

            // Sync Payer Phone
            const phoneInput = document.getElementById('payerPhone');
            if (phoneInput) {
                phoneInput.value = state.payerPhone || '';
                phoneInput.addEventListener('input', (e) => {
                    if (window.cart && window.cart.checkoutState) {
                        window.cart.checkoutState.payerPhone = e.target.value;
                        window.cart.saveCheckoutState();
                    }
                });
            }

            // استدعاء حاسم متأخر: للتغلب على أي مسح للكلاسات أو تصفير يتم من دوال الـ Ajax الخارجية أو cart.js
            setTimeout(() => {
                if (typeof updateLiveSummary === 'function') updateLiveSummary();
            }, 1000);
        });

        window.promoOrder = { code: '', amount: 0, percentage: 0 };
        window.promoShipping = { code: '', amount: 0, percentage: 0 };

        window.applyPromo = function(type) {
            const codeInput = document.getElementById(type === 'order' ? 'promoInputOrder' : 'promoInputShipping');
            const applyBtn = document.getElementById(type === 'order' ? 'applyBtnOrder' : 'applyBtnShipping');
            const msgEl = document.getElementById(type === 'order' ? 'promoMsgOrder' : 'promoMsgShipping');

            if (!msgEl || !applyBtn || !codeInput) return;

            const promoState = type === 'order' ? window.promoOrder : window.promoShipping;

            // Extra safety: block shipping promo if in pickup/in-shop mode
            if (type === 'shipping') {
                const activeBtn = document.querySelector('.global-types .order-type-opt.active');
                if (activeBtn && (activeBtn.getAttribute('data-type') === 'pickup' || activeBtn.getAttribute('data-type') === 'in-shop')) {
                    msgEl.textContent = (window.texts && window.texts.ShippingPromoNotValidForPickup) || "لا يمكن إضافة كوبون توصيل عند الاستلام من الفرع";
                    msgEl.className = "promo-msg error";
                    msgEl.style.display = 'block';
                    return;
                }
            }

            // If a coupon is already applied for this type, clicking should remove it
            if (promoState.code) {
                promoState.code = '';
                promoState.amount = 0;
                promoState.percentage = 0;

                codeInput.value = '';
                codeInput.disabled = false;
                applyBtn.textContent = (window.texts && window.texts.Apply) || "تطبيق";
                applyBtn.classList.remove('remove');
                msgEl.style.display = 'none';

                if (typeof updateGlobalDeliveryCost === 'function') updateGlobalDeliveryCost();
                if (typeof updateLiveSummary === 'function') updateLiveSummary();
                return;
            }

            const code = codeInput.value.trim();
            if (!code) {
                msgEl.textContent = (window.texts && window.texts.EnterPromoCodeError) || "يرجى إدخال الكوبون";
                msgEl.className = "promo-msg error";
                msgEl.style.display = 'block';
                return;
            }

            const modeLabel = type === 'shipping' ? (window.texts && window.texts.ShippingDiscount) || "خصم التوصيل" : (window.texts && window.texts.OrderDiscount) || "خصم الطلب";
            msgEl.textContent = `${(window.texts && window.texts.CheckingPromo) || "جاري التحقق من"} ${modeLabel}...`;
            msgEl.className = "promo-msg";
            msgEl.style.display = 'block';

            const subtotalEl = document.getElementById("globalSubtotal");
            const subtotal = parseFloat(subtotalEl?.innerText.replace(/[^\d.]/g, '')) || 0;
            const deliveryEl = document.getElementById("globalTotalDelivery");
            const delivery = parseFloat(deliveryEl?.innerText.replace(/[^\d.]/g, '')) || 0;

            const amountToSend = type === 'shipping' ? delivery : subtotal;

            $.ajax({
                type: "POST",
                url: "CheckOut.aspx/ValidateCoupon",
                data: JSON.stringify({ couponCode: code, amount: amountToSend, type: type }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(res) {
                    const data = res.d;
                    if (data && data.success) {
                        const discountAmount = parseFloat(data.discountAmount) || 0;
                        const percentage = parseFloat(data.percentage) || 0;

                        promoState.code = code;
                        promoState.amount = discountAmount;
                        promoState.percentage = percentage;

                        const successTitle = ((window.texts && window.texts.PromoAppliedSuccess) || "تم تطبيق {0} بنجاح").replace('{0}', modeLabel);
                        const savedText = ((window.texts && window.texts.PromoSavedAmount) || "وفرت {0} {1} ({2}%)").replace('{0}', discountAmount.toFixed(2)).replace('{1}', (window.texts && window.texts.Currency) || "ج.م").replace('{2}', percentage);

                        msgEl.innerHTML = `✅ <strong>${successTitle}</strong><br><small>${savedText}</small>`;
                        msgEl.className = "promo-msg success";
                        msgEl.style.display = 'block';

                        applyBtn.textContent = (window.texts && window.texts.RemoveCoupon) || "إزالة الكوبون";
                        applyBtn.classList.add('remove');
                        codeInput.disabled = true;
                    } else {
                        const errorMsg = data && data.message ? data.message : ((window.texts && window.texts.PromoErrorInvalid) || "الكوبون غير صالح");
                        msgEl.innerHTML = `❌ ${errorMsg}`;
                        msgEl.className = "promo-msg error";
                        msgEl.style.display = 'block';

                        promoState.code = '';
                        promoState.amount = 0;
                        promoState.percentage = 0;
                    }
                    if (typeof updateGlobalDeliveryCost === 'function') updateGlobalDeliveryCost();
                    if (typeof updateLiveSummary === 'function') updateLiveSummary();
                },
                error: function() {
                    msgEl.innerHTML = `❌ ${(window.texts && window.texts.ConnectionErrorText) || "حدثت مشكلة أثناء الاتصال بالخادم"}`;
                    msgEl.className = "promo-msg error";
                    msgEl.style.display = 'block';

                    promoState.code = '';
                    promoState.amount = 0;
                    promoState.percentage = 0;

                    if (typeof updateGlobalDeliveryCost === 'function') updateGlobalDeliveryCost();
                    if (typeof updateLiveSummary === 'function') updateLiveSummary();
                }
            });
        };

        window.selectPayment = function(el, method, isInitialLoad = false) {
            document.querySelectorAll('.pay-options-grid .pay-option').forEach(opt => opt.classList.remove('selected'));
            el.classList.add('selected');
            const radio = el.querySelector('input');
            if (radio) radio.checked = true;

            const state = (window.cart && window.cart.checkoutState) ? window.cart.checkoutState : {};
            const proofWrap = document.getElementById('paymentProofWrap');
            const preview = document.getElementById('paymentProofPreview');
            const phoneInput = document.getElementById('payerPhone');
            const fileInput = document.getElementById('paymentProofFile');

            // Reset proof and phone when manually toggling payment method
            if (!isInitialLoad && state.paymentMethod !== method) {
                if (phoneInput) phoneInput.value = '';
                if (fileInput) fileInput.value = '';
                if (preview) {
                    preview.src = '';
                    preview.style.display = 'none';
                }
                if (window.cart) {
                    window.cart.checkoutState.paymentProofBase64 = "";
                    window.cart.checkoutState.payerPhone = "";
                }
            }

            // Update checkoutState
            if (window.cart) {
                window.cart.checkoutState.paymentMethod = method;
                window.cart.saveCheckoutState();
            }

            if (method === 'cash' || method === 'visa') {
                if (proofWrap) proofWrap.style.display = 'none';
            } else {
                if (proofWrap) proofWrap.style.display = 'flex';
                // Show preview if we have one in state
                if (preview && window.cart && window.cart.checkoutState.paymentProofBase64) {
                    preview.src = (window.cart.checkoutState.paymentProofBase64.startsWith('data:') ? '' : 'data:image/png;base64,') + window.cart.checkoutState.paymentProofBase64;
                    preview.style.display = 'block';
                }
            }
            if (typeof updateLiveSummary === 'function') updateLiveSummary();
        };

        window.selectContactMethod = function(el, method) {
            document.querySelectorAll('.contact-methods .pay-option').forEach(opt => opt.classList.remove('selected'));
            el.classList.add('selected');

            // Update checkoutState
            if (window.cart) {
                window.cart.checkoutState.contactMethod = method;
                window.cart.saveCheckoutState();
            }

            if (typeof updateLiveSummary === 'function') updateLiveSummary();
        };

        window.previewPaymentProof = function(input) {
            const preview = document.getElementById('paymentProofPreview');
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';

                    // Also save to state
                    if (window.cart) {
                        window.cart.checkoutState.paymentProofBase64 = e.target.result.split(',')[1];
                        window.cart.saveCheckoutState();
                    }
                }
                reader.readAsDataURL(input.files[0]);
            }
        };

        window.setGlobalOrderType = function(type) {
            // Save to checkoutState
            if (window.cart) {
                window.cart.checkoutState.deliveryMethod = type;
                window.cart.saveCheckoutState();
            }
            // Compatibility fallback
            localStorage.setItem("deliveryMethod", type);

            const container = document.querySelector('.global-types');
            if(!container) return;
            const btns = container.querySelectorAll('.order-type-opt');
            btns.forEach(btn => {
                if (btn.getAttribute('data-type') === type) {
                    btn.classList.add('active');
                } else {
                    btn.classList.remove('active');
                }
            });

            const globalMsg = document.getElementById('globalPickupMsg');
            if (globalMsg) {
                globalMsg.style.display = (type === 'pickup' || type === 'in-shop') ? 'block' : 'none';
                if (type === 'in-shop') {
                    globalMsg.innerText = texts.InShopSummaryMsg || "طريقة الاستلام المختارة هي طلب في المحل";
                } else if (type === 'pickup') {
                    globalMsg.innerText = texts.PickupWarning || "⚠️ الاستلام من المحل يسري على جميع المحلات في الطلب، وغير مسئولين في حال تغيير رأيكم لاحقاً.";
                }
            }

            // Handle Contact Method Section Visibility - Hide if pickup or in-shop
            const contactSection = document.getElementById('contactMethodSection');
            if (contactSection) {
                contactSection.style.display = (type === 'pickup' || type === 'in-shop') ? 'none' : 'block';
            }

            // Handle Label Change
            const timeLabel = document.getElementById('deliveryTimeLabel');
            const summaryTimeLabel = document.querySelector('.summary-line .summary-label-time');

            if (timeLabel) {
                timeLabel.innerHTML = (type === 'pickup' || type === 'in-shop')
                    ? `${texts.PrepTime || "وقت تحضير الطلب"}:`
                    : `${texts.ExpectedDeliveryTime || "وقت التوصيل المتوقع"}:`;
            }

            if (summaryTimeLabel) {
                summaryTimeLabel.innerHTML = (type === 'pickup' || type === 'in-shop')
                    ? (texts.PrepTime || "وقت تحضير الطلب")
                    : (texts.TotalDeliveryTime || "إجمالي وقت التوصيل");
            }

            // Hide Shipping Promo Group and Reset if Pickup/In-Shop is selected
            const shippingPromoGroup = document.getElementById('shippingPromoGroup');
            if (shippingPromoGroup) {
                if (type === 'pickup' || type === 'in-shop') {
                    shippingPromoGroup.style.display = 'none';

                    // Force Reset Shipping Promo State & Input
                    const shippingInput = document.getElementById('promoInputShipping');
                    if (shippingInput) {
                        shippingInput.value = '';
                        shippingInput.disabled = false;
                    }
                    const shippingBtn = document.getElementById('applyBtnShipping');
                    if (shippingBtn) {
                        shippingBtn.textContent = (window.texts && window.texts.Apply) || "تطبيق";
                        shippingBtn.classList.remove('remove');
                    }
                    const shippingMsg = document.getElementById('promoMsgShipping');
                    if (shippingMsg) shippingMsg.style.display = 'none';

                    window.promoShipping = { code: '', amount: 0, percentage: 0 };
                } else {
                    shippingPromoGroup.style.display = 'block';
                }
            }

            // Update all individual shop delivery fees in UI
            document.querySelectorAll('.vendor-group-footer').forEach(footer => {
                const shopId = footer.getAttribute('data-vendor');
                const shopDeliveryEl = document.getElementById(`shopDelivery-${shopId}`);
                const originalFee = footer.getAttribute('data-delivery-fee') || '0';

                // Keep the original fee visible for feedback even if in pickup mode
                if(shopDeliveryEl) shopDeliveryEl.innerHTML = `<strong>${originalFee} ${texts.Currency || 'ج.م'}</strong>`;
            });

            // Sync with global delivery cost
            updateGlobalDeliveryCost();

            // Re-init scheduling to update defaults/minDate
            if (typeof initDeliveryTimeScheduling === 'function') initDeliveryTimeScheduling();

            if (typeof updateLiveSummary === 'function') updateLiveSummary();
        };

        window.setVendorOrderType = function(vendorId, type) {
            // Deprecated but kept for compatibility if needed elsewhere
            setGlobalOrderType(type);
        };

        function updateGlobalDeliveryCost() {
            const texts = window.texts || {};
            const activeBtn = document.querySelector('.global-types .order-type-opt.active');
            const activeType = activeBtn ? activeBtn.getAttribute('data-type') : 'delivery';
            const isPickup = activeType === 'pickup' || activeType === 'in-shop';

            const summary = JSON.parse(localStorage.getItem("cartSummary") || "{}");
            let globalOrderTotalDelivery = isPickup ? 0 : (parseFloat(summary.delivery) || 0);

            // First Order Free Delivery Banner next to delivery fee
            const firstOrderMsgEl = document.getElementById("firstOrderDeliveryMsg");
            if (firstOrderMsgEl) {
                if (window.isFirstOrder && !isPickup && globalOrderTotalDelivery === 0) {
                    firstOrderMsgEl.style.display = "block";
                    firstOrderMsgEl.innerHTML = `<i class="fa-solid fa-gift"></i> ${texts.FirstOrderFreeDelivery || "توصيل مجاني بمناسبة طلبك الأول!"}`;
                } else {
                    firstOrderMsgEl.style.display = "none";
                }
            }

            // Update Global Summary UI
            let shippingDiscount = isPickup ? 0 : (window.promoShipping?.amount || 0);
            const displayDeliveryValue = Math.max(0, globalOrderTotalDelivery - shippingDiscount);

            const globalTotalDeliveryEl = document.getElementById("globalTotalDelivery");
            if (globalTotalDeliveryEl) {
                if (shippingDiscount > 0) {
                    globalTotalDeliveryEl.innerHTML = `<span style="text-decoration: line-through; color: #888; margin-inline-end: 8px; font-weight: normal;">${globalOrderTotalDelivery.toFixed(2)} ${texts.Currency || 'ج.م'}</span><span style="color: #2b8a3e; font-weight: bold;">${displayDeliveryValue.toFixed(2)} ${texts.Currency || 'ج.م'}</span>`;
                } else {
                    globalTotalDeliveryEl.innerHTML = `<strong>${globalOrderTotalDelivery.toFixed(2)} ${texts.Currency || 'ج.م'}</strong>`;
                }
            }

            const globalDeliveryEl = document.getElementById("Deliverycost");
            if (globalDeliveryEl) {
                if (shippingDiscount > 0) {
                    globalDeliveryEl.innerHTML = `<span style="text-decoration: line-through; color: #888; margin-inline-end: 8px; font-weight: normal;">${globalOrderTotalDelivery.toFixed(2)} ${texts.Currency || 'ج.م'}</span><span style="color: #2b8a3e; font-weight: bold;">${displayDeliveryValue.toFixed(2)} ${texts.Currency || 'ج.م'}</span>`;
                } else {
                    globalDeliveryEl.innerHTML = `<strong>${displayDeliveryValue.toFixed(2)} ${texts.Currency || 'ج.م'}</strong>`;
                }
            }

            // Update Final Total
            const subtotalEl = document.getElementById("globalSubtotal");
            const finalTotalEl = document.getElementById("globalFinalTotal");

            if (subtotalEl && finalTotalEl) {
                const subtotal = parseFloat(summary.subtotal) || 0;
                let orderDiscount = window.promoOrder?.amount || 0;

                if (orderDiscount > 0) {
                    const discountedSubtotal = Math.max(0, subtotal - orderDiscount);
                    subtotalEl.innerHTML = `<span style="text-decoration: line-through; color: #888; margin-inline-end: 8px; font-weight: normal;">${subtotal.toFixed(2)} ${texts.Currency || 'ج.م'}</span><span style="color: #2b8a3e; font-weight: bold;">${discountedSubtotal.toFixed(2)} ${texts.Currency || 'ج.م'}</span>`;
                } else {
                    subtotalEl.innerHTML = `<strong>${subtotal.toFixed(2)} ${texts.Currency || 'ج.م'}</strong>`;
                }

                const newTotal = (subtotal + globalOrderTotalDelivery) - orderDiscount - shippingDiscount;
                finalTotalEl.innerText = `${newTotal.toFixed(2)} ${texts.Currency || 'ج.م'}`;
            }

            // Show/Hide Pickup Message
            const globalPickupMsg = document.getElementById("globalPickupMsg");
            if (globalPickupMsg) globalPickupMsg.style.display = isPickup ? "block" : "none";
        }

        function toBase64(file) {
            return new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onload = () => resolve(reader.result.split(',')[1]); // Only send the base64 part
                reader.onerror = error => reject(error);
            });
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
