<%@ Page Title="" Language="C#" MasterPageFile="~/Ar/MasterPages/MasterPage.master" AutoEventWireup="true"
    CodeFile="PlaceShop.aspx.cs" Inherits="Ar_PlaceShop" %>
    <asp:Content ID="Content3" ContentPlaceHolderID="head" Runat="Server">

        <asp:Literal ID="ltPageTitle" runat="server" Text="<%$ Resources:texts, PagePlaceShopTitle %>"></asp:Literal>
    </asp:Content>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true" />
           <style>
            .swal2-html-container{
                padding: 0;
            }
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
                max-width: 1280px !important;
                width: 100%;

                h2 {
                    display: flex;
                    justify-content: space-between;
                    gap: 1rem;
                    align-items: start;
                    margin: 0;
                    line-height: 1.2;
                }

                #filterIcon {
                    display: none;
                }
            }


            .route {
                display: none !important;
            }

            .availableShop {
                display: flex;
                gap: 1rem;
                margin-block: 1.5rem;
                padding: 1.5rem;
                background:white ;
                border-radius: 1.25rem;
                border: 1px solid rgba(0, 0, 0, 0.1);
                box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                text-decoration: none;
                color: inherit;

                img {
                    width: 130px;
                    height: 130px;
                    aspect-ratio: 1;
                    object-position: center;
                    object-fit: cover;
                    border: 1px solid rgba(0, 0, 0, 0.08);
                    border-radius: 1rem;
                    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
                }

                &:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(0,0,0,0.06);
                    background: #fff;

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

            .availableShopName{
                display: flex;
                justify-content: space-between;
                align-items: baseline;
                gap: 0.5rem;
            }
            .availableShopName,
            .shopFoods {
                line-height: 1.25;
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
                display: none !important;
                margin-block: 25px;
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
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
                        border: 1px solid rgba(0, 0, 0, 0.1);
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
                border: 1px solid rgba(0, 0, 0, 0.1);

                .foodNavLinks {
                    display: flex;
                    flex-direction: column;

                    a {
                        padding: 1rem 0.5rem;
                        transition: var(--transition);

                        &:hover {
                            background-color: #f8f9fa;
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
                background-color: white;
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
                padding: 0;
                display: flex;
                flex-direction: column;
                list-style: none;
                gap: 1.25rem;
                transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
                overflow: visible;
                height: auto;
                opacity: 1;
                padding-bottom: 2rem;
            }

            .foodDrowdown.active {
                /* Preserve active state if JS still toggles it */
                display: flex !important;
            }

            .foodList {
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }



            .foodItem {
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                align-items: stretch;
                padding: 1.25rem;
                background: #fff;
                border-radius: 1.25rem;
                border: 1px solid #f2f2f2;
                margin-bottom: 1rem;
                transition: all 0.3s ease;
                gap: 1.5rem;
                cursor: pointer;
                position: relative;
            }

            .foodItem:hover {
                box-shadow: 0 10px 30px rgba(0,0,0,0.08);
                border-color: var(--fd-blue);
                transform: translateY(-3px);
            }

            .foodDetailsContainer {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                flex: 1;
                text-align: start;
                height: 100%;
                padding-block: 0.75rem;
            }

            .foodText {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
                .foodName{
                    font-size: 1rem !important;
                }
            }

            .foodName {
                font-size: 1.2rem;
                font-weight: 700;
                color: #1a1a1a;
                margin: 0;
                line-height: 1.2;
                transition: color 0.3s ease;
            }

            .foodItem:hover .foodName {
                color: var(--fd-blue);
            }

            .foodContent {
                font-size: 0.95rem;
                color: #777;
                line-height: 1.5;
                margin: 0;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .foodPricing {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                margin-top: auto;
            }

            .foodNewPrice {
                font-size: 1.15rem;
                font-weight: 800;
                color: #1a1a1a;
                white-space: nowrap;
            }

            .foodOldPrice {
                font-size: 0.95rem;
                color: #bbb;
                text-decoration: line-through;
                font-weight: 500;
                white-space: nowrap;
            }

            .foodImage {
                pointer-events: none !important;
                position: relative;
                width: 150px !important;
                height: 100% !important;
                max-width: 150px !important;
                flex-shrink: 0;
                background-color: #f8f8f8;
                padding: 0 !important;
                display: flex;
                justify-content: center;
                align-items: center;
                border-radius: 1.5rem !important;
                overflow: hidden;
                border: none !important;

            }

            .foodImage img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: inherit;
                box-shadow: 0 6px 15px rgba(0,0,0,0.1);
                aspect-ratio: 1;
                position: relative;
                z-index: 1;
                background-color: #fff;
            }

            .foodItem{
                flex-direction: row-reverse !important;
                column-gap: 1.5rem !important;
                img{
                    border-radius: 1.5rem !important;
                    background-color: var(--fd-blue);
                }
            }

            .addToCart {
                   position: absolute;
    bottom: 10px;
    inset-inline-start: 10px;
                display: flex;
                justify-content: center;
                align-items: center;
                height: fit-content !important;
                pointer-events: auto; /* Changed from none to auto */
                z-index: 2;
            }

            .addToCartBtn {
                width: 36px !important;
                height: 36px !important;
                background-color: #fff;
                color: #ff6b00;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                box-shadow: 0 4px 15px rgba(0,0,0,0.15);
                font-size: 1.4rem;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                cursor: pointer;
                pointer-events: auto; /* Enable clicks */
            }

            .qty-control {
                pointer-events: auto; /* Enable clicks */
            }

            .foodItem:hover .addToCartBtn {
                transform: scale(1.1);
                background-color: #ff6b00;
                color: #fff;
            }

            @media (max-width: 480px) {
                .foodText{
                    pointer-events: none;
                }


                .foodDrowdown {
                    display: grid !important;
                    grid-template-columns: repeat(2, 1fr) !important;
                    gap: 10px !important;
                    padding-inline: 5px !important;
                    height: auto !important;
                    opacity: 1 !important;
                    /* overflow: visible !important; */
                }

                .foodDrowdown{
                    padding-inline: 0px !important;
                }

                #openedShopFoods{
                    padding-inline: 1rem !important;
                }

                .foodItem:not(.custom-item) {
                    flex-direction: column-reverse !important;
                    padding: 0px !important;
                    gap: 0.5rem !important;
                    margin-bottom: 0 !important;
                    border-radius: 1rem !important;
                    height: 100% !important;
                    align-items: stretch !important;
                    display: flex !important;
                }

                .foodImage:not(.custom-item .foodImage) {
                    width: 100% !important;
                    height: auto !important;
                    max-width: 100% !important;
                    aspect-ratio: 1 !important;
                }

                .foodImage img {
                    border-radius: 0.75rem !important;
                    height: 100% !important;
                    width: 100% !important;
                    object-fit: cover !important;
                }

                .foodDetailsContainer {
                    padding: 0.5rem !important;
                    gap: 4px !important;
                    height: auto !important;
                    flex: 1 !important;
                    pointer-events: none;
                }
                .foodText,.foodName{
                    flex:1;
                }

                .foodText{
                    pointer-events: none;
                    .foodName {
                        font-size: 0.8rem !important;
                        display: -webkit-box !important;
                        -webkit-line-clamp: 2 !important;
                        -webkit-box-orient: vertical !important;
                        overflow: hidden !important;
                        line-height: 1.5 !important;
                    }
                }

                .foodContent {
                    font-size: 0.7rem !important;
                    -webkit-line-clamp: 2 !important;
                    display: -webkit-box !important;
                    -webkit-box-orient: vertical !important;
                    overflow: hidden !important;
                    min-height: 2.4em !important;
                    margin: 0 !important;
                    line-height: 1.5 !important;
                }

                .foodPricing {
                    margin-top: 4px !important;
                    gap: 4px !important;
                    justify-content: flex-start !important;
                }

                .foodNewPrice {
                    font-size: 0.9rem !important;
                }

                .foodOldPrice {
                    font-size: 0.75rem !important;
                }

                .addToCart {
                    bottom: 5px !important;
                    inset-inline-start: 5px !important;
                }

                .addToCartBtn {
                    width: 32px !important;
                    height: 32px !important;
                    font-size: 1rem !important;
                }
            }


            #cartHolder {
                display: flex;
                flex-direction: column;
                border-radius: 0.5rem;
                overflow: hidden;
                justify-content: center;
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
                gap: 1.5rem;
                justify-content: center;
                border: 1px solid #fffcfc;
                border-bottom-left-radius: 1.25rem;
                border-bottom-right-radius: 1.25rem;
                align-items: center;
                text-align: center;
                background-color: #fff;
                margin-bottom: 0px !important;
                font-size: 1.1rem;
                padding: 3.5rem 2rem;
                font-weight: 600;
                color: #888;

                i {
                    font-size: 4.5rem;
                    color: #eee;
                    margin-bottom: 0.5rem;
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
                border: 1px solid rgba(0, 0, 0, 0.1);
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
                border-top: 1px solid rgba(0, 0, 0, 0.1);
                border-right: 1px solid rgba(0, 0, 0, 0.1);
                rotate: 45deg;
                right: -16px;
                top: var(--arrow-top, 50%);
                aspect-ratio: 1;
                z-index: -1;
            }

            /* --- MODERN CLEAN CART DESIGN --- */
            #shoppingCart {
                /* Container overlay is handled in css_web.css, but we can override if needed */
            }

            #cartHolder {
                background: #fff;
                border-radius: 1.5rem;
                box-shadow: 0 20px 40px rgba(0,0,0,0.15);
                max-width: 480px;
                width: 95%;
                position: relative;
                border: none;
                display: flex;
                flex-direction: column;
            }

            .shoppingCartTitle {
                font-size: 1.4rem;
                color: #222;
                margin-bottom: 1.5rem;
                text-align: center;
                border-bottom: 1px solid #fffcfc;
                padding-bottom: 1rem;
                font-weight: 800;
            }

            #closeCartBtn {
                position: absolute;
                top: 1.25rem;
                right: 1.25rem;
                font-size: 1.8rem;
                color: #bbb;
                cursor: pointer;
                transition: all 0.2s;
                line-height: 1;
                z-index: 10;
            }

            #closeCartBtn:hover {
                color: #ff4d4f;
                transform: rotate(90deg);
            }

            .orderedItemsWrapper {
                max-height: 380px;
                overflow-y: auto;
                margin-bottom: 1.5rem;
                padding-inline: 4px;
                display: flex;
                flex-direction: column;
                gap: 2px;
            }

            /* Custom Scrollbar */
            .orderedItemsWrapper::-webkit-scrollbar {
                width: 5px;
            }
            .orderedItemsWrapper::-webkit-scrollbar-track {
                background: #f9f9f9;
            }
            .orderedItemsWrapper::-webkit-scrollbar-thumb {
                background: #ddd;
                border-radius: 10px;
            }

            .cartShopLabel {
                background-color: #f8f9fa;
                padding: 10px 14px;
                margin: 15px 0 8px 0;
                border-radius: 12px;
                font-weight: 700;
                font-size: 0.9rem;
                color: var(--fd-blue);
                display: flex;
                align-items: center;
                gap: 8px;
                border-left: 4px solid var(--fd-blue);
            }

            .orderedItem {
                display: grid;
                grid-template-columns: auto 1fr auto auto;
                align-items: center;
                gap: 12px;
                padding: 14px 10px;
                border-radius: 12px;
                transition: background 0.2s;
                background: #fff;
            }

            .orderedItem:hover {
                background: #fcfcfc;
            }
.swiper {
    overflow: initial !important;
}
            .orderedItemName {
                font-weight: 600;
                color: #333;
                font-size: 0.8rem;
                line-height: 1.4;
                display: -webkit-box;
                -webkit-line-clamp: 1;
                min-height: fit-content;
                text-overflow: ellipsis;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .totalItemPrice {
                font-weight: 700;
                color: #222;
                font-size: 0.8rem;
                white-space: nowrap;
            }

            .removeCartItem {
                color: #ccc;
                font-size: 1.1rem;
                cursor: pointer;
                transition: all 0.2s;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-right: 10px;
            }

            .removeCartItem:hover {
                color: #ff4d4f;
                transform: scale(1.15);
            }

            .addons-badge {
                font-size: 0.7rem;
                color: #ffc119;
                background: #fff9e6;
                padding: 1px 6px;
                border-radius: 4px;
                margin-top: 3px;
                display: inline-block;
                width: fit-content;
            }

            .orderedItemMain {
                display: flex;
                flex-direction: column;
                flex-grow: 1;
                margin: 0 12px;
            }

            .cartItemAmountHandlers {
                display: flex;
                align-items: center;
                background: #f5f6f7;
                border-radius: 10px;
                padding: 3px;
                margin: 0;
                min-width: fit-content;
                gap: 2px;
            }

            .increase, .decrease {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 28px;
                height: 28px;
                border: none;
                background: #fff;
                color: #444;
                cursor: pointer;
                border-radius: 7px;
                transition: all 0.2s;
                font-size: 0.8rem;
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
                padding: 0;
            }

            .increase:hover, .decrease:hover {
                background: var(--fd-blue);
                color: #fff;
            }

            .itemAmount {
                min-width: 26px;
                text-align: center;
                font-weight: 800;
                font-size: 0.9rem;
                color: #222;
            }

            /* --- Cart Summary --- */
            #inCartItems {
                background: #fafbfc;
                border-radius: 1.25rem;
  margin-bottom: 0px !important;
                padding: 1.25rem;
                padding-top: 0px !important;
                display: flex;
                flex-direction: column;
                gap: 0.8rem;
            }

            .preDeliveryFeeAmount, .deliveryAmount, .afterDeliveryFeeAmount {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 0.95rem;
            }

            .preDeliveryFeeAmount p, .deliveryAmount p {
                color: #777;
                font-weight: 500;
                margin: 0;
            }

            .subtotalAmount, .deliveryFee {
                font-weight: 700;
                color: #444;
            }

            .afterDeliveryFeeAmount {
                margin-top: 5px;
                padding-top: 12px;
                border-top: 1px dashed #ddd;
            }

            .afterDeliveryFeeAmount p {
                font-size: 1.1rem;
                font-weight: 700;
                color: #222;
                margin: 0;
            }

            .totalAmount {
                font-size: 1.3rem;
                font-weight: 900;
                color: var(--fd-blue);
            }

            /* --- Actions --- */
            .confirmCartActions {
                display: flex;
                gap: 12px;
            }

            .confirmCartActions .submit {
                flex: 1;
                background: var(--fd-blue);
                color: #fff;
                height: 52px;
                border: none;
                border-radius: 14px;
                font-weight: 700;
                font-size: 1.05rem;
                cursor: pointer;
                transition: all 0.3s;
                box-shadow: 0 10px 20px rgba(255, 193, 25, 0.2);
                overflow: hidden;
            }

            .confirmCartActions .submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 24px rgba(255, 193, 25, 0.3);
                opacity: 1;
            }

            #emptyCartBtn {
                width: 40px;
                height: 40px;
                background: #fff;
                border: 1px solid #eee;
                color: #ff4d4f;
                border-radius: 14px;
                cursor: pointer;
                transition: all 0.2s;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 0;
                font-size: 1.25rem;
            }

            #emptyCartBtn:hover {
                background: #fff1f0;
                border-color: #ffccc7;
                transform: scale(1.05);
            }

            /* --- Empty State --- */
            #emptyCart {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 40px 20px;
                text-align: center;
            }

            #emptyCart i {
                font-size: 4.5rem;
                color: #eee;
                margin-bottom: 20px;
                filter: drop-shadow(0 4px 8px rgba(0,0,0,0.02));
            }

            #emptyCart p {
                color: #999;
                font-size: 1.1rem;
                font-weight: 600;
                margin: 0;
            }

            .confirmCartActions a {
                color: inherit;
                text-decoration: none;
                width: 100%;
                display: block;
            }

            /* &#1578;&#1606;&#1587;&#1610;&#1602; &#1588;&#1585;&#1610;&#1591; &#1575;&#1604;&#1578;&#1589;&#1606;&#1610;&#1601;&#1575;&#1578; (Food Categories Bar) */
            .food-categories-mobile-bar {
                width: 100%;
                display: block;
                /* &#1604;&#1593;&#1585;&#1590; &#1575;&#1604;&#1605;&#1608;&#1576;&#1575;&#1610;&#1604; */
                padding: 10px 0;
                background-color: #fff;
                /* &#1582;&#1604;&#1601;&#1610;&#1577; &#1576;&#1610;&#1590;&#1575;&#1569; &#1606;&#1592;&#1610;&#1601;&#1577; */
                margin-bottom: 15px;
                box-shadow: none;
                /* &#1573;&#1586;&#1575;&#1604;&#1577; &#1575;&#1604;&#1592;&#1604; */
            }

            /* &#1581;&#1575;&#1608;&#1610;&#1577; &#1575;&#1604;&#1578;&#1605;&#1585;&#1610;&#1585; &#1575;&#1604;&#1571;&#1601;&#1602;&#1610; */
            .categories-list-scroll {
                display: flex;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
                overscroll-behavior: contain;
                touch-action: pan-x pan-y;
                gap: 20px;
                /* &#1605;&#1587;&#1575;&#1601;&#1577; &#1571;&#1603;&#1576;&#1585; &#1576;&#1610;&#1606; &#1575;&#1604;&#1603;&#1604;&#1605;&#1575;&#1578; */
                padding: 0 15px;
                justify-content: flex-start;
                /* &#1578;&#1585;&#1578;&#1610;&#1576; &#1575;&#1604;&#1593;&#1606;&#1575;&#1589;&#1585; &#1605;&#1606; &#1575;&#1604;&#1576;&#1583;&#1575;&#1610;&#1577; */
            }

            /* 2. &#1578;&#1606;&#1587;&#1610;&#1602; &#1593;&#1606;&#1589;&#1585; &#1575;&#1604;&#1578;&#1589;&#1606;&#1610;&#1601; (&#1575;&#1604;&#1603;&#1604;&#1605;&#1577; &#1601;&#1602;&#1591;) */
            .category-pill {
                /* &#1571;&#1604;&#1594;&#1610;&#1606;&#1575; Flexbox &#1607;&#1606;&#1575; &#1604;&#1571;&#1606;&#1606;&#1575; &#1604;&#1575; &#1606;&#1581;&#1578;&#1575;&#1580; &#1604;&#1578;&#1585;&#1578;&#1610;&#1576; &#1575;&#1604;&#1589;&#1608;&#1585;&#1577; &#1608;&#1575;&#1604;&#1606;&#1589; */
                display: inline-block;
                padding: 5px 0;
                /* &#1605;&#1587;&#1575;&#1601;&#1577; &#1581;&#1608;&#1604; &#1575;&#1604;&#1606;&#1589; (&#1571;&#1593;&#1604;&#1609; &#1608;&#1571;&#1587;&#1601;&#1604;) */
                color: #888;
                /* &#1604;&#1608;&#1606; &#1585;&#1605;&#1575;&#1583;&#1610; &#1582;&#1601;&#1610;&#1601; &#1604;&#1604;&#1606;&#1589; &#1594;&#1610;&#1585; &#1575;&#1604;&#1606;&#1588;&#1591; */
                text-decoration: none;
                font-size: 16px;
                font-weight: 500;
                white-space: nowrap;
                /* &#1605;&#1606;&#1593; &#1575;&#1604;&#1606;&#1589; &#1605;&#1606; &#1575;&#1604;&#1606;&#1586;&#1608;&#1604; &#1604;&#1587;&#1591;&#1585; &#1580;&#1583;&#1610;&#1583; */
                border-radius: 0;
                /* &#1604;&#1575; &#1606;&#1581;&#1578;&#1575;&#1580; &#1604;&#1571;&#1610; &#1586;&#1608;&#1575;&#1610;&#1575; &#1605;&#1587;&#1578;&#1583;&#1610;&#1585;&#1577; */
                border: none;
                /* &#1573;&#1586;&#1575;&#1604;&#1577; &#1571;&#1610; &#1573;&#1591;&#1575;&#1585; &#1571;&#1608; &#1582;&#1604;&#1601;&#1610;&#1577; */
                transition: color 0.2s;
                flex-shrink: 0;
            }

            /* 3. &#1573;&#1604;&#1594;&#1575;&#1569; &#1578;&#1606;&#1587;&#1610;&#1602; &#1575;&#1604;&#1589;&#1608;&#1585; &#1578;&#1605;&#1575;&#1605;&#1575;&#1611; (&#1604;&#1604;&#1578;&#1571;&#1603;&#1583;) */
            .category-pill img {
                display: none;
                /* &#1573;&#1582;&#1601;&#1575;&#1569; &#1575;&#1604;&#1589;&#1608;&#1585;&#1577; &#1578;&#1605;&#1575;&#1605;&#1575;&#1611; */
            }

            /* &#1581;&#1575;&#1604;&#1577; &#1575;&#1604;&#1593;&#1606;&#1589;&#1585; &#1575;&#1604;&#1606;&#1588;&#1591; */
            .category-pill.active {
                color: #ffc119;
                /* &#1604;&#1608;&#1606; &#1575;&#1604;&#1606;&#1589; &#1610;&#1589;&#1576;&#1581; &#1605;&#1605;&#1610;&#1586;&#1575;&#1611; */

                /* ✅ &#1575;&#1604;&#1571;&#1607;&#1605;: &#1573;&#1606;&#1588;&#1575;&#1569; &#1575;&#1604;&#1582;&#1591; &#1575;&#1604;&#1587;&#1601;&#1604;&#1610; */
                border-bottom: 3px solid #ffc119;
            }
            .status-badge {
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 700;
                margin-inline-start: 12px;
                display: inline-flex;
                align-items: center;
                vertical-align: middle;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }
            .deliveryTime i,
            .deliveryPayment i,
            .minPay i{
                font-size: 10px;
            }


            .status-badge.open {
                background-color: #ecfdf5;
                color: #059669;
                border: 1px solid #10b981;
            }
            .status-badge.closed {
                background-color: #fef2f2;
                color: #dc2626;
                border: 1px solid #ef4444;
            }
            .route{
                color: white;
            }
            #shopBanner{
                width: 100%;
                position: absolute;
                height: 333px;
                top: 0;
                right:0;
                overflow: hidden;
                left:0;
                border-bottom-right-radius: 1rem;
                border-bottom-left-radius: 1rem;
                z-index: -1;
                margin: auto;
            }
            #shopBanner img{
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        </style>
        <script>
            // Function to handle click and set the active class
            function setActiveCategory(clickedElement, event) {
                // 1. (\u0627\u062e\u062a\u064a\u0627\u0631\u064a) \u0645\u0646\u0639 \u0627\u0644\u062a\u0648\u062c\u064a\u0647 \u0627\u0644\u0641\u0648\u0631\u064a \u0644\u0644\u0631\u0627\u0628\u0637 \u062d\u062a\u0649 \u0646\u0646\u0647\u064a \u0639\u0645\u0644 JavaScript
                // event.preventDefault();

                // 2. \u062c\u0644\u0628 \u062c\u0645\u064a\u0639 \u0639\u0646\u0627\u0635\u0631 \u0627\u0644\u062a\u0635\u0646\u064a\u0641\u0627\u062a
                const allPills = document.querySelectorAll('.category-pill');

                // 3. \u0625\u0632\u0627\u0644\u0629 \u0643\u0644\u0627\u0633 'active' \u0645\u0646 \u0643\u0644 \u0627\u0644\u0639\u0646\u0627\u0635\u0631
                allPills.forEach(pill => {
                    pill.classList.remove('active');
                });

                // 4. \u0625\u0636\u0627\u0641\u0629 \u0643\u0644\u0627\u0633 'active' \u0644\u0644\u0639\u0646\u0635\u0631 \u0627\u0644\u0630\u064a \u062a\u0645 \u0627\u0644\u0646\u0642\u0631 \u0639\u0644\u064a\u0647
                clickedElement.classList.add('active');

                // 5. (\u0625\u062c\u0631\u0627\u0621 \u0627\u062e\u062a\u064a\u0627\u0631\u064a) \u064a\u0645\u0643\u0646\u0643 \u0647\u0646\u0627 \u0627\u0633\u062a\u062e\u062f\u0627\u0645 fetch \u0623\u0648 AJAX
                // \u0644\u062a\u062d\u0645\u064a\u0644 \u0642\u0627\u0626\u0645\u0629 \u0627\u0644\u0637\u0639\u0627\u0645 \u0627\u0644\u062c\u062f\u064a\u062f\u0629 \u0628\u0646\u0627\u0621\u064b \u0639\u0644\u0649 ID \u0627\u0644\u062a\u0635\u0646\u064a\u0641 \u0627\u0644\u0630\u064a \u062a\u0645 \u0627\u062e\u062a\u064a\u0627\u0631\u0647
                // const categoryId = clickedElement.getAttribute('data-category-id');
                // loadFoodItems(categoryId);

                // 6. \u0625\u0630\u0627 \u0643\u0646\u062a \u062a\u0631\u064a\u062f \u0627\u0633\u062a\u0639\u0627\u062f\u0629 \u0648\u0638\u064a\u0641\u0629 \u0627\u0644\u062a\u0648\u062c\u064a\u0647 \u0644\u0644\u0631\u0627\u0628\u0637 \u0628\u0639\u062f \u0627\u0646\u062a\u0647\u0627\u0621 \u0627\u0644\u0639\u0645\u0644\u064a\u0629:
                // window.location.href = clickedElement.href;
            }

            // Function to set the initial active category on page load (from Query String)
            document.addEventListener('DOMContentLoaded', () => {
                // \u062c\u0644\u0628 ID \u0627\u0644\u062a\u0635\u0646\u064a\u0641 \u0645\u0646 \u0631\u0627\u0628\u0637 URL (Query String)
                const urlParams = new URLSearchParams(window.location.search);
                const initialId = urlParams.get('categoryID') || '1'; // \u0627\u0644\u0642\u064a\u0645\u0629 \u0627\u0644\u0627\u0641\u062a\u0631\u0627\u0636\u064a\u0629 '1'

                // \u0627\u0644\u0628\u062d\u062b \u0639\u0646 \u0627\u0644\u0639\u0646\u0635\u0631 \u0627\u0644\u0630\u064a \u064a\u0637\u0627\u0628\u0642 \u0627\u0644\u0640 ID
                const initialActive = document.querySelector(`.category-pill[data-category-id="${initialId}"]`);

                // \u062a\u0637\u0628\u064a\u0642 \u0627\u0644\u0643\u0644\u0627\u0633 \u0627\u0644\u0646\u0634\u0637 \u0625\u0630\u0627 \u0648\u064f\u062c\u062f
                if (initialActive) {
                    initialActive.classList.add('active');
                }
            });
        </script>
        <section id="openedShopFoods">

<figure id="shopBanner">
    <img src="https://static.vecteezy.com/system/resources/thumbnails/006/633/040/small/online-shopping-spring-on-phone-flower-pink-big-sale-banner-marketing-poster-fashion-vector.jpg" alt="">
</figure>

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
                <div style="position: relative;">
                    <div class="shop-img-wrapper" style="position: relative; width: 130px; height: 130px;">
                        <asp:Image ID="imgplace" runat="server" style="width:100%; height:100%; border-radius:1rem; object-fit:cover;" />
                        <div class="favorite-heart"
                             onclick="toggleFavorite(event, this)"
                             id="shopHeartIcon">
                            <i class="fa-regular fa-heart"></i>
                        </div>
                    </div>

                    <span class="shopRating" style="text-align:center;padding-top:5px" id="shopRating"
                        runat="server"></span>
                    <div id="isOpened" hidden><asp:Literal ID="ltIsOpened" runat="server"></asp:Literal></div>
                    <div id="rawRating" hidden><asp:Literal ID="ltRawRating" runat="server"></asp:Literal></div>
                </div>
                <div class="availableShopDesc">
                    <h3 class="availableShopName" style="display: flex; align-items: center;">
                        <asp:Literal ID="ltname" runat="server"></asp:Literal>
                        <span id="shopStatusBadge" runat="server"></span>
                    </h3>
                    <p class="shopFoods">
                        <asp:Literal ID="ltDetails" runat="server"></asp:Literal>
                    </p>


                    <div class="shopDelivery">
                        <span class="deliveryTime">
                            <i class="fa-regular fa-clock"></i>
                            <asp:Literal ID="ltReceiveIn" runat="server" Text="<%$ Resources:texts, ReceiveIn %>">
                            </asp:Literal>


                            <span class="timer">
                                <asp:Literal ID="ltdeliverytime" runat="server"></asp:Literal>
                            </span>
                            <asp:Literal ID="ltReceiveInMinutes" runat="server"
                                Text="<%$ Resources:texts, ReceiveInMinutes %>"></asp:Literal>

                        </span>
                        <span class="delieveryPayment">
<i class="fa-solid fa-truck-fast"></i>
                            <asp:Literal ID="ltDeliveryService" runat="server"
                                Text="<%$ Resources:texts, DeliveryService %>"></asp:Literal>:&nbsp; <span id="deliveryCostValue"><asp:Literal
                                ID="ltDeliveryCost" runat="server"></asp:Literal></span>
                            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:texts, currency %>">
                            </asp:Literal>
                        </span>
                        <span class="minPay">
                            <i class="fa-solid fa-money-bill-wave"></i>
                            <asp:Literal ID="ltMinOrderText" runat="server" Text="<%$ Resources:texts, MinOrder %>">
                            </asp:Literal>:&nbsp;<asp:Literal ID="ltmincost" runat="server"></asp:Literal>
                        </span>
                    </div>

                    <div class="shopPayMethods">
                        <p class="pay-badge tracking">
                            <i class="fa-solid fa-map-location-dot"></i>
                            <asp:Literal ID="ltLiveTracking" runat="server" Text="<%$ Resources:texts, LiveTracking %>"></asp:Literal>
                        </p>

                        <p class="pay-badge safe">
                            <i class="fa-solid fa-shield-halved"></i>
                            <asp:Literal ID="ltSafeDelivery" runat="server" Text="<%$ Resources:texts, SafeDelivery %>"></asp:Literal>
                        </p>

                        <p class="pay-badge free">
                            <i class="fa-solid fa-gift"></i>
                            <asp:Literal ID="ltFirstOrderFree" runat="server" Text="<%$ Resources:texts, FirstOrderFree %>"></asp:Literal>
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
                                <%-- &#1610;&#1605;&#1603;&#1606;&#1603; &#1575;&#1587;&#1578;&#1582;&#1583;&#1575;&#1605; &#1575;&#1604;&#1605;&#1606;&#1591;&#1602; &#1575;&#1604;&#1588;&#1585;&#1591;&#1610; &#1604;&#1578;&#1591;&#1576;&#1610;&#1602; active class &#1607;&#1606;&#1575; --%>

                                    <a href='#<%# Eval("id")%>' class="category-pill" data-category-id="<%# Eval(" ID")
                                        %>"
                                        onclick="setActiveCategory(this, event)">

                                        <%-- &#1607;&#1584;&#1607; &#1607;&#1610; &#1575;&#1604;&#1589;&#1608;&#1585;&#1577; &#1575;&#1604;&#1605;&#1589;&#1594;&#1585;&#1577; &#1604;&#1604;&#1578;&#1589;&#1606;&#1610;&#1601; --%>
                                            <img src='<%# Eval("PhotoUrl") %>' alt='<%# Eval("Name") %>' />
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

                        <%-- &#1605;&#1579;&#1575;&#1604; &#1579;&#1575;&#1576;&#1578;: --%>
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


                            <div class="custom-selection-section">
                                <h2 class="foodListTitle">&#1575;&#1582;&#1578;&#1575;&#1585; &#1593;&#1604;&#1609; &#1584;&#1608;&#1602;&#1603;</h2>
                                <div class="custom-grid">
                                    <div class="foodItem custom-item" id="custom-1" data-price="130" data-product-name="&#1585;&#1576;&#1593; &#1603;&#1610;&#1604;&#1608; &#1588;&#1575;&#1608;&#1585;&#1605;&#1575; &#1601;&#1585;&#1575;&#1582;" onclick="handleProductClick(this, event)">
                                        <div class="foodDetailsContainer">
                                            <div class="foodText">
                                                <h4 class="foodName">&#1585;&#1576;&#1593; &#1603;&#1610;&#1604;&#1608;</h4>
                                                <p class="foodContent">&#1588;&#1575;&#1608;&#1585;&#1605;&#1575; &#1583;&#1580;&#1575;&#1580; &#1605;&#1593; &#1575;&#1604;&#1578;&#1608;&#1605;&#1610;&#1577;</p>
                                            </div>
                                            <div class="foodPricing">
                                                <span class="foodNewPrice">130 &#1580;.&#1605;</span>
                                            </div>
                                        </div>
                                        <div class="foodImage">
                                            <div class="product-qty-badge">0</div>
                                            <img src="images/placeholderImage.webp" alt="product">
                                            <div class="addToCart">
                                                <span class="addToCartBtn"><i class="fa-solid fa-angle-left"></i></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="foodItem custom-item" id="custom-2" data-price="260" data-product-name="&#1606;&#1589;&#1601; &#1603;&#1610;&#1604;&#1608; &#1588;&#1575;&#1608;&#1585;&#1605;&#1575; &#1601;&#1585;&#1575;&#1582;" onclick="handleProductClick(this, event)">
                                        <div class="foodDetailsContainer">
                                            <div class="foodText">
                                                <h4 class="foodName">&#1606;&#1589;&#1601; &#1603;&#1610;&#1604;&#1608;</h4>
                                                <p class="foodContent">&#1588;&#1575;&#1608;&#1585;&#1605;&#1575; &#1583;&#1580;&#1575;&#1580; &#1604;&#1584;&#1610;&#1584;&#1577;</p>
                                            </div>
                                            <div class="foodPricing">
                                                <span class="foodNewPrice">260 &#1580;.&#1605;</span>
                                            </div>
                                        </div>
                                        <div class="foodImage">
                                            <div class="product-qty-badge">0</div>
                                            <img src="images/placeholderImage.webp" alt="product">
                                            <div class="addToCart">
                                                <span class="addToCartBtn"><i class="fa-solid fa-angle-left"></i></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="foodItem custom-item" id="custom-3" data-price="520" data-product-name="&#1603;&#1610;&#1604;&#1608; &#1588;&#1575;&#1608;&#1585;&#1605;&#1575; &#1601;&#1585;&#1575;&#1582;" onclick="handleProductClick(this, event)">
                                        <div class="foodDetailsContainer">
                                            <div class="foodText">
                                                <h4 class="foodName">&#1603;&#1610;&#1604;&#1608; &#1588;&#1575;&#1608;&#1585;&#1605;&#1575;</h4>
                                                <p class="foodContent">&#1608;&#1580;&#1576;&#1577; &#1593;&#1575;&#1574;&#1604;&#1610;&#1577; &#1605;&#1578;&#1603;&#1575;&#1605;&#1604;&#1577;</p>
                                            </div>
                                            <div class="foodPricing">
                                                <span class="foodNewPrice">520 &#1580;.&#1605;</span>
                                            </div>
                                        </div>
                                        <div class="foodImage">
                                            <div class="product-qty-badge">0</div>
                                            <img src="images/placeholderImage.webp" alt="product">
                                            <div class="addToCart">
                                                <span class="addToCartBtn"><i class="fa-solid fa-angle-left"></i></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="foodItem custom-item" id="custom-4" data-price="85" data-product-name="&#1588;&#1575;&#1608;&#1585;&#1605;&#1575; &#1589;&#1575;&#1580;" onclick="handleProductClick(this, event)">
                                        <div class="foodDetailsContainer">
                                            <div class="foodText">
                                                <h4 class="foodName">&#1588;&#1575;&#1608;&#1585;&#1605;&#1575; &#1589;&#1575;&#1580;</h4>
                                                <p class="foodContent">&#1587;&#1575;&#1606;&#1583;&#1608;&#1578;&#1588; &#1589;&#1575;&#1580; &#1605;&#1605;&#1610;&#1586;</p>
                                            </div>
                                            <div class="foodPricing">
                                                <span class="foodNewPrice">85 &#1580;.&#1605;</span>
                                            </div>
                                        </div>
                                        <div class="foodImage">
                                            <div class="product-qty-badge">0</div>
                                            <img src="images/placeholderImage.webp" alt="product">
                                            <div class="addToCart">
                                                <span class="addToCartBtn"><i class="fa-solid fa-angle-left"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
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
                                                <span style="display: none;" class="dropDownBtn"><i class="fa-solid fa-angles-down"></i></span>
                                        </h2>

                                        <ul class="foodDrowdown">
                                            <asp:Repeater ID="rptFoodItems" runat="server">
                                                <ItemTemplate>                                                    <li class="foodItem <%# Convert.ToBoolean(Eval("isCustom")) ? "custom-item" : "" %>"
                                                        id='<%# Eval("id") %>'
                                                        data-product-name='<%# System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName=="en" ? Eval("NameEn") : Eval("Name") %>'
                                                        data-price='<%# Eval("NewPrice") %>'
                                                        onclick="handleProductClick(this, event)">
                                                         <div class="product-qty-badge">0</div>
                                                        <div class="foodDetailsContainer">
                                                            <div class="foodText">
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
                                                                <%# Convert.ToInt32(Eval("PrepearMin")) > 0 ?
                                                                    string.Format("<small style='color: #e67e22; font-weight: bold;'><i class='fa-solid fa-utensils'></i> {0} &#1583;&#1602;&#1610;&#1602;&#1577;</small>", Eval("PrepearMin"))
                                                                    : "" %>
                                                            </div>
                                                            <div class="foodPricing">
                                                                <%# (Eval("OldPrice").ToString()) !=(Eval("NewPrice").ToString())
                                                                    ? "<span class='foodOldPrice'>EGP" + Convert.ToDecimal(Eval("OldPrice")).ToString("0.##") + "</span>" : "" %>
                                                                    <span class="foodNewPrice">
                                                                        <%# Convert.ToDecimal(Eval("NewPrice")).ToString("0.##") %>
                                                                        <%= Resources.Texts.Currency %>
                                                                    </span>
                                                            </div>
                                                        </div>

                                                        <div class="foodImage">
                                                            <img src='<%# Eval("PhotoUrl") %>' alt="food image" onerror="this.onerror=null;this.src='images/placeholderImage.webp';" />
                                                            <div class="addToCart">
                                                                <%# Convert.ToBoolean(Eval("isCustom")) ?
                                                                    "<span class='addToCartBtn'><i class='fa-solid fa-angle-left'></i></span>" :
                                                                    @"<span class='addToCartBtn' onclick='handleAddToCartClick(event, this)' title='" + Resources.Texts.addtocart + @"'>
                                                                        <i class='fa fa-plus'></i>
                                                                    </span>
                                                                    <div class='qty-control card-qty' style='display:none;' onclick='event.stopPropagation()'>
                                                                        <button onclick='handleCardQty(event, this, -1)'><i class='fa-solid fa-minus'></i></button>
                                                                        <span class='qty-val'>1</span>
                                                                        <button onclick='handleCardQty(event, this, 1)'><i class='fa-solid fa-plus'></i></button>
                                                                    </div>"
                                                                %>
                                                            </div>
                                                        </div>
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
                            <span id="closeCartBtn" class="close"><i class="fa-solid fa-xmark"></i></span>

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
                                    <span class="subtotalAmount">0.00 &#1580;.&#1605;</span>
                                </div>

                                <div class="deliveryAmount">
                                    <p>
                                        <asp:Literal ID="ltDeliveryFeeText" runat="server"
                                            Text="<%$ Resources:texts, DeliveryFee %>"></asp:Literal>
                                        <i class="fa-solid fa-circle-info"></i>
                                    </p>
                                    <span class="deliveryFee">0.00 &#1580;.&#1605;</span>
                                </div>



                                <div class="afterDeliveryFeeAmount">
                                    <p>
                                        <asp:Literal ID="ltTotalAmountText" runat="server"
                                            Text="<%$ Resources:texts, TotalAmount %>"></asp:Literal>
                                    </p>
                                    <span class="totalAmount">0.00 &#1580;.&#1605;</span>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
        <link href="css/css_web.css" rel="stylesheet" />

        <style>
            /* &#1581;&#1575;&#1608;&#1610;&#1577; &#1575;&#1604;&#1578;&#1589;&#1606;&#1610;&#1601; - &#1580;&#1593;&#1604; &#1575;&#1604;&#1593;&#1606;&#1575;&#1589;&#1585; &#1601;&#1608;&#1602; &#1576;&#1593;&#1590;&#1607;&#1575; */
.category-pill {
    display: flex;
    flex-direction: column; /* &#1604;&#1580;&#1593;&#1604; &#1575;&#1604;&#1589;&#1608;&#1585;&#1577; &#1601;&#1608;&#1602; &#1608;&#1575;&#1604;&#1603;&#1604;&#1605;&#1577; &#1578;&#1581;&#1578; */
    align-items: center;
    gap: 8px; /* &#1605;&#1587;&#1575;&#1601;&#1577; &#1576;&#1610;&#1606; &#1575;&#1604;&#1589;&#1608;&#1585;&#1577; &#1608;&#1575;&#1604;&#1606;&#1589; */
    padding: 10px;
    text-decoration: none;
    transition: all 0.3s ease;
    flex-shrink: 0;
    border-bottom: 3px solid transparent; /* &#1582;&#1591; &#1588;&#1601;&#1575;&#1601; &#1575;&#1601;&#1578;&#1585;&#1575;&#1590;&#1610;&#1575;&#1611; */
}

/* &#1573;&#1592;&#1607;&#1575;&#1585; &#1608;&#1578;&#1606;&#1587;&#1610;&#1602; &#1575;&#1604;&#1589;&#1608;&#1585;&#1577; */
.category-pill img {
    display: block !important; /* &#1573;&#1604;&#1594;&#1575;&#1569; &#1575;&#1604;&#1600; display: none &#1575;&#1604;&#1587;&#1575;&#1576;&#1602; */
    width: 60px;  /* &#1610;&#1605;&#1603;&#1606;&#1603; &#1578;&#1603;&#1576;&#1610;&#1585; &#1571;&#1608; &#1578;&#1589;&#1594;&#1610;&#1585; &#1575;&#1604;&#1581;&#1580;&#1605; */
    height: 60px;
    border-radius: 50%; /* &#1604;&#1580;&#1593;&#1604; &#1589;&#1608;&#1585;&#1577; &#1575;&#1604;&#1601;&#1574;&#1577; &#1583;&#1575;&#1574;&#1585;&#1610;&#1577; */
    object-fit: cover;
    background-color: #f8f8f8;
    border: 1px solid #eee;
}

/* &#1581;&#1575;&#1604;&#1577; &#1575;&#1604;&#1593;&#1606;&#1589;&#1585; &#1575;&#1604;&#1606;&#1588;&#1591; */
.category-pill.active {
    color: #ffc119;
    border-bottom: 3px solid #ffc119;
}

.category-pill.active img {
    border-color: #ffc119;
    transform: scale(1.1); /* &#1578;&#1603;&#1576;&#1610;&#1585; &#1576;&#1587;&#1610;&#1591; &#1604;&#1604;&#1589;&#1608;&#1585;&#1577; &#1575;&#1604;&#1606;&#1588;&#1591;&#1577; */
}
        /* Navbar Icons Visibility for this page only */
        .search-nav-icon, .fav-nav-icon {
            display: flex !important;
        }

        @media (max-width: 768px) {
            .action-buttons {
                display: flex;
                gap: 5px;
            }
            .icon-btn {
                padding: 5px;
            }
        }

        .bottom-sheet-modal {
            border-top-left-radius: 20px !important;
            border-top-right-radius: 20px !important;
            border-bottom-left-radius: 0 !important;
            border-bottom-right-radius: 0 !important;
            margin: 0 !important;
            max-height: 80vh;
            overflow: hidden;
        }

        .compact-modal-container {
            width: 100%;
            padding-bottom: env(safe-area-inset-bottom);
        }

        .compact-modal-header {
            padding: 15px;
            display: flex;
            justify-content: center;
            position: relative;
            background: white;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
        }

        .compact-modal-header .handle {
            width: 40px;
            height: 4px;
            background: #ddd;
            border-radius: 2px;
        }

        .compact-close {
            position: absolute;
            right: 15px;
            top: 10px;
            background: #fffcfc;
            border: none;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .title-price-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 5px;
        }

        .compact-price {
            font-weight: 700;
            color: var(--fd-blue);
            font-size: 1.1rem;
        }

        /* Upsell Redesign Styles */
        .upsell-section .section-subtitle {
            font-size: 0.85rem;
            color: #666;
            margin-top: -5px;
            margin-bottom: 15px;
        }

        .upsell-card-new {
            background: transparent;
            text-align: left;
            width: 140px !important;
        }

        .upsell-img-wrapper {
            position: relative;
            width: 100%;
            aspect-ratio: 1/1;
            margin-bottom: 8px;
        }

        .upsell-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 16px;
        }

        .upsell-add-btn {
            position: absolute;
            bottom: 8px;
            right: 8px;
            width: 32px;
            height: 32px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            cursor: pointer;
            color: #ff6b00;
            font-size: 14px;
            transition: transform 0.2s;
        }

        .upsell-add-btn:active { transform: scale(0.9); }

        .upsell-info h5 {
            font-size: 0.9rem;
            margin: 0;
            font-weight: 600;
            color: #333;
        }

        .upsell-info p {
            font-size: 0.85rem;
            color: #666;
            margin: 2px 0 0;
            font-weight: 500;
        }

        .related-products-swiper {
            height: auto !important;
            padding-bottom: 10px !important;
        }
        .upsell-card-new {
            height: fit-content !important;
        }

        .upsell-card-new .qty-control {
            position: absolute;
            bottom: 8px;
            right: 8px;
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            border-radius: 20px;
            padding: 2px 5px;
            display: none;
            align-items: center;
            gap: 5px;
            z-index: 10;
        }
        .upsell-card-new .qty-control button {
            width: 24px;
            height: 24px;
            font-size: 10px;
        }
        .upsell-card-new .qty-control .upsell-qty-val {
            font-size: 12px;
            min-width: 15px;
            text-align: center;
        }

        .upsell-badge {
            position: absolute;
            top: 5px;
            right: 5px;
            background: #ffc119;
            color: #fff;
            width: 22px;
            height: 22px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: bold;
            z-index: 15;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        /* Bottom Sheet Animations */
        @keyframes slideInUpCustom {
            from { transform: translateY(100%); }
            to { transform: translateY(0); }
        }
        @keyframes slideOutDownCustom {
            from { transform: translateY(0); }
            to { transform: translateY(100%); }
        }
        .animate__slideInUp {
            animation: slideInUpCustom 0.3s cubic-bezier(0.4, 0, 0.2, 1) forwards !important;
        }
        .animate__slideOutDown {
            animation: slideOutDownCustom 0.25s cubic-bezier(0.4, 0, 0.2, 1) forwards !important;
        }

        .bottom-sheet-modal {
            border-bottom-left-radius: 0 !important;
            border-bottom-right-radius: 0 !important;
        }

        .fav-nav-icon.active i {
            color: palevioletred  !important;
        }
        </style>

    <script>
        let currentTriggeringProduct = null;

        function openProductModal(triggerEl, productName, description = "\u0637\u0639\u0645 \u0644\u0627 \u064a\u0642\u0627\u0648\u0645 \u0645\u062d\u0636\u0631 \u0645\u0646 \u0623\u062c\u0648\u062f \u0627\u0644\u0645\u0643\u0648\u0646\u0627\u062a", isCustom = false, price = 100) {
            currentTriggeringProduct = triggerEl;
            window.history.pushState({ modal: 'product' }, '');

            basePrice = price;
            addonsPrice = 0;
            quantity = 1;

            const modalOptions = {
                html: `
                    <div class="${isCustom ? 'full-modal-container' : 'compact-modal-container'}">
                        ${isCustom ? `
                        <div class="modal-banner">
                            <img src="${triggerEl.querySelector('img')?.src || 'images/placeholderImage.webp'}" alt="${productName}">
                            <button class="modal-close-btn" onclick="Swal.close()">
                                <i class="fa-solid fa-xmark"></i>
                            </button>
                        </div>
                        ` : `
                        <div class="compact-modal-header">
                            <div class="handle"></div>
                            <button class="compact-close" onclick="Swal.close()"><i class="fa-solid fa-xmark"></i></button>
                        </div>
                        `}

                        <div class="modal-content-body">
                            <div class="modal-main-info">
                                <div class="title-price-row">
                                    <h1>${productName}</h1>
                                    <span class="compact-price">${price} \u062c.\u0645</span>
                                </div>
                                <p class="modal-desc">${description}</p>
                            </div>

                            ${isCustom ? `
                            <div class="modal-section">
                                <div class="section-header">
                                    <h3>\u0627\u062e\u062a\u0627\u0631 \u0627\u0644\u062d\u062c\u0645</h3>
                                    <span class="required-badge">\u0625\u062c\u0628\u0627\u0631\u064a</span>
                                </div>
                                <div class="options-list">
                                    <div class="option-row active" onclick="selectModalOption(this, 0)">
                                        <span>\u0635\u063a\u064a\u0631</span>
                                        <div class="price-radio">
                                            <span>+0 \u062c.\u0645</span>
                                            <div class="radio-circle"></div>
                                        </div>
                                    </div>
                                    <div class="option-row" onclick="selectModalOption(this, 50)">
                                        <span>\u0648\u0633\u0637</span>
                                        <div class="price-radio">
                                            <span>+50 \u062c.\u0645</span>
                                            <div class="radio-circle"></div>
                                        </div>
                                    </div>
                                    <div class="option-row" onclick="selectModalOption(this, 100)">
                                        <span>\u0643\u0628\u064a\u0631</span>
                                        <div class="price-radio">
                                            <span>+100 \u062c.\u0645</span>
                                            <div class="radio-circle"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-section">
                                <div class="section-header">
                                    <h3>\u0627\u0622\u0642\u062a\u0631\u0627\u062d\u0627\u062a \u0633\u0631\u064a\u0639\u0629</h3>
                                    <span class="optional-badge">\u0627\u062e\u062a\u064a\u0627\u0631\u064a</span>
                                </div>
                                <div class="swiper quick-choices-swiper">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide quick-card" onclick="toggleQuickChoice(this, 25)">
                                            <div class="quick-card-badge"><i class="fa-solid fa-fire"></i> \u0631\u0627\u0626\u062c</div>
                                            <h4>\u0646\u0648\u062a\u064a\u0644\u0627</h4>
                                            <p>+25 \u062c.\u0645</p>
                                            <div class="check-box"></div>
                                        </div>
                                        <div class="swiper-slide quick-card" onclick="toggleQuickChoice(this, 15)">
                                            <h4>\u0645\u0643\u0633\u0631\u0627\u062a</h4>
                                            <p>+15 \u062c.\u0645</p>
                                            <div class="check-box"></div>
                                        </div>
                                        <div class="swiper-slide quick-card" onclick="toggleQuickChoice(this, 30)">
                                            <div class="quick-card-badge"><i class="fa-solid fa-fire"></i> \u0627\u0624\u0643\u062b\u0631 \u0645\u0628\u064a\u0639\u0627\u064b</div>
                                            <h4>\u0625\u0636\u0627\u0641\u0629 \u062c\u0628\u0646\u0629</h4>
                                            <p>+30 \u062c.\u0645</p>
                                            <div class="check-box"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            ` : ''}

                            <div class="modal-section">
                                <div class="section-header">
                                    <h3>\u0645\u0644\u0627\u062d\u0638\u0627\u062a</h3>
                                    <span class="optional-badge">\u0627\u062e\u062a\u064a\u0627\u0631\u064a</span>
                                </div>
                                <textarea id="product-notes" placeholder="\u0623\u0636\u0641 \u0645\u0644\u0627\u062d\u0638\u0627\u062a\u0643 \u0647\u0646\u0627..."></textarea>
                            </div>

                            ${isCustom ? `
                            <div class="modal-section">
                                <div class="section-header">
                                    <h3>\u0625\u0636\u0627\u0641\u0627\u062a \u0623\u062e\u0631\u0649</h3>
                                    <span class="optional-badge">\u0627\u062e\u062a\u064a\u0627\u0631\u064a</span>
                                </div>
                                <div class="extras-list">
                                    <div class="extra-item" onclick="toggleExtra(this, 10)">
                                        <div class="extra-text">
                                            <span>\u0639\u0633\u0644</span>
                                            <small>+10 \u062c.\u0645</small>
                                        </div>
                                        <div class="check-box"></div>
                                    </div>
                                    <div class="extra-item" onclick="toggleExtra(this, 20)">
                                        <div class="extra-text">
                                            <span>\u0641\u0648\u0627\u0643\u0647</span>
                                            <small>+20 \u062c.\u0645</small>
                                        </div>
                                        <div class="check-box"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-section upsell-section">
                                <div class="section-header">
                                    <h3>\u063a\u0627\u0644\u0628\u0627\u064b \u0645\u0627 \u064a\u064f\u0637\u0644\u0628 \u0645\u0639</h3>
                                </div>
                                <div class="swiper related-products-swiper">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide upsell-card-new">
                                            <div class="upsell-img-wrapper">
                                                <div class="upsell-badge" style="display:none;">1</div>
                                                <img src="images/placeholderImage.webp" alt="upsell">
                                                <div class="upsell-add-btn" onclick="addUpsellItem(this, 25)">
                                                    <i class="fa-solid fa-plus"></i>
                                                </div>
                                                <div class="qty-control" onclick="event.stopPropagation()">
                                                    <button onclick="updateUpsellQty(this, -1, 25)"><i class="fa-solid fa-minus"></i></button>
                                                    <span class="upsell-qty-val">1</span>
                                                    <button onclick="updateUpsellQty(this, 1, 25)"><i class="fa-solid fa-plus"></i></button>
                                                </div>
                                            </div>
                                            <div class="upsell-info">
                                                <h5>\u0639\u0635\u064a\u0631 \u0628\u0631\u062a\u0642\u0627\u0644</h5>
                                                <p>EGP 25.00</p>
                                            </div>
                                        </div>
                                        <div class="swiper-slide upsell-card-new">
                                            <div class="upsell-img-wrapper">
                                                <div class="upsell-badge" style="display:none;">1</div>
                                                <img src="images/placeholderImage.webp" alt="upsell">
                                                <div class="upsell-add-btn" onclick="addUpsellItem(this, 35)">
                                                    <i class="fa-solid fa-plus"></i>
                                                </div>
                                                <div class="qty-control" onclick="event.stopPropagation()">
                                                    <button onclick="updateUpsellQty(this, -1, 35)"><i class="fa-solid fa-minus"></i></button>
                                                    <span class="upsell-qty-val">1</span>
                                                    <button onclick="updateUpsellQty(this, 1, 35)"><i class="fa-solid fa-plus"></i></button>
                                                </div>
                                            </div>
                                            <div class="upsell-info">
                                                <h5>\u0633\u0644\u0637\u0629 \u062e\u0636\u0631\u0627\u0621</h5>
                                                <p>EGP 35.00</p>
                                            </div>
                                        </div>
                                        <div class="swiper-slide upsell-card-new">
                                            <div class="upsell-img-wrapper">
                                                <div class="upsell-badge" style="display:none;">1</div>
                                                <img src="images/placeholderImage.webp" alt="upsell">
                                                <div class="upsell-add-btn" onclick="addUpsellItem(this, 15)">
                                                    <i class="fa-solid fa-plus"></i>
                                                </div>
                                                <div class="qty-control" onclick="event.stopPropagation()">
                                                    <button onclick="updateUpsellQty(this, -1, 15)"><i class="fa-solid fa-minus"></i></button>
                                                    <span class="upsell-qty-val">1</span>
                                                    <button onclick="updateUpsellQty(this, 1, 15)"><i class="fa-solid fa-plus"></i></button>
                                                </div>
                                            </div>
                                            <div class="upsell-info">
                                                <h5>\u062a\u0648\u0645\u064a\u0629</h5>
                                                <p>EGP 15.00</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            ` : ''}
                        </div>

                        <div class="modal-footer-sticky">
                            <div class="qty-control">
                                <button onclick="updateModalQty(-1)"><i class="fa-solid fa-minus"></i></button>
                                <span id="modal-qty">1</span>
                                <button onclick="updateModalQty(1)"><i class="fa-solid fa-plus"></i></button>
                            </div>
                            <button class="add-to-cart-big" onclick="submitModalCart()">
                                <span>\u0625\u0636\u0627\u0641\u0629 \u0644\u0644\u0633\u0644\u0629</span>
                                <strong id="modal-total-price">${price} \u062c.\u0645</strong>
                            </button>
                        </div>
                    </div>
                `,
                showConfirmButton: false,
                width: isCustom ? '600px' : '100%',
                padding: '0',
                background: '#f8f9fa',
                position: isCustom ? 'center' : 'bottom',
                customClass: { popup: isCustom ? 'product-modal-popup' : 'bottom-sheet-modal' },
                scrollbarPadding: false,
                showClass: { popup: isCustom ? 'swal2-show' : 'animate__animated animate__slideInUp animate__faster' },
                hideClass: { popup: isCustom ? 'swal2-hide' : 'animate__animated animate__slideOutDown animate__faster' },
                didOpen: () => {
                    if (isCustom) {
                        new Swiper('.quick-choices-swiper', { slidesPerView: 'auto', spaceBetween: 12, freeMode: true });
                        new Swiper('.related-products-swiper', { slidesPerView: 'auto', spaceBetween: 12, freeMode: true });
                    }
                },
                willClose: () => {
                    if (window.history.state && window.history.state.modal === 'product') {
                        window.history.back();
                    }
                }
            };
            Swal.fire(modalOptions);
        }

        function toggleShopFavorite() {
            const shopId = document.getElementById('shopId')?.innerText.trim();
            if (!shopId) return;

            let favorites = JSON.parse(localStorage.getItem('favoriteShops') || '[]');
            const index = favorites.indexOf(shopId);
            const favIcon = document.querySelector('#favIconNav i');

            if (index > -1) {
                favorites.splice(index, 1);
                if (favIcon) favIcon.className = 'fa-regular fa-heart';
                Swal.fire({ toast: true, position: 'top-end', icon: 'info', title: '\u062a\u0645\u062a \u0627\u0644\u0625\u0632\u0627\u0644\u0629 \u0645\u0646 \u0627\u0644\u0645\u0641\u0636\u0644\u0629', showConfirmButton: false, timer: 1500 });
            } else {
                favorites.push(shopId);
                if (favIcon) favIcon.className = 'fa-solid fa-heart';
                Swal.fire({ toast: true, position: 'top-end', icon: 'success', title: '\u062a\u0645\u062a \u0627\u0644\u0625\u0636\u0627\u0641\u0629 \u0644\u0644\u0645\u0641\u0636\u0644\u0629', showConfirmButton: false, timer: 1500 });
            }
            localStorage.setItem('favoriteShops', JSON.stringify(favorites));
        }

        function checkFavoriteStatus() {
            const shopId = document.getElementById('shopId')?.innerText.trim();
            const favIcon = document.querySelector('#favIconNav i');
            if (!shopId || !favIcon) return;

            let favorites = JSON.parse(localStorage.getItem('favoriteShops') || '[]');
            if (favorites.indexOf(shopId) > -1) {
                favIcon.className = 'fa-solid fa-heart';
            } else {
                favIcon.className = 'fa-regular fa-heart';
            }
        }
        document.addEventListener('DOMContentLoaded', checkFavoriteStatus);

        let basePrice = 100;
        let addonsPrice = 0;
        let quantity = 1;

        function selectModalOption(el, addPrice) {
            el.parentElement.querySelectorAll('.option-row').forEach(r => r.classList.remove('active'));
            el.classList.add('active');
            basePrice = 100 + addPrice;
            updateModalTotal();
        }

        function toggleQuickChoice(el, price) {
            el.classList.toggle('active');
            addonsPrice += el.classList.contains('active') ? price : -price;
            updateModalTotal();
        }

        function toggleExtra(el, price) {
            el.classList.toggle('active');
            addonsPrice += el.classList.contains('active') ? price : -price;
            updateModalTotal();
        }

        function updateModalQty(delta) {
            quantity = Math.max(1, quantity + delta);
            document.getElementById('modal-qty').innerText = quantity;
            updateModalTotal();
        }

        function updateModalTotal() {
            const total = (basePrice + addonsPrice) * quantity;
            const el = document.getElementById('modal-total-price');
            if (el) el.innerText = total + ' \u062c.\u0645';
        }

        function handleProductClick(el, event) {
            // Check if this is a custom item (like Quarter/Half Shawarma)
            const isCustom = el.classList.contains('custom-item');

            // For regular items, block modal if clicking cart buttons
            if (!isCustom) {
                if (event.target.closest('.addToCart') || event.target.closest('.qty-control')) return;
            }
            const name = el.getAttribute('data-product-name');
            const desc = el.querySelector('.foodContent')?.innerText || '';
            const price = parseFloat(el.getAttribute('data-price')) || 100;
            openProductModal(el, name, desc, isCustom, price);
        }

        function handleAddToCartClick(event, btn) {
            event.preventDefault();
            event.stopPropagation();
            const itemEl = btn.closest('.foodItem');
            const id = itemEl.getAttribute('id');
            const name = itemEl.getAttribute('data-product-name');
            const price = parseFloat(itemEl.getAttribute('data-price'));

            const shopId = String(document.getElementById('shopId')?.innerText.trim() || '');
            if (window.cart) {
                window.cart.addItem({
                    id, name, price,
                    shopId: shopId,
                    shopName: document.querySelector('.shop-header-info h1')?.innerText || ''
                }, 1);
            }

            // UI Switch to Qty Control
            syncProductBadges();
        }

        function handleCardQty(event, btn, delta) {
            event.preventDefault();
            event.stopPropagation();
            const itemEl = btn.closest('.foodItem');
            const id = itemEl.getAttribute('id');
            const shopId = document.getElementById('shopId')?.innerText.trim() || '';

            if (window.cart) {
                if (delta > 0) window.cart.increaseItem(id, shopId);
                else window.cart.decreaseItem(id, shopId);
            }
            syncProductBadges();
        }

        function syncProductBadges() {
            if (!window.cart || !window.cart.items) return;
            const shopId = String(document.getElementById('shopId')?.innerText.trim() || '');
            const counts = {};
            window.cart.items.forEach(item => {
                if (String(item.shopId) === shopId) {
                    counts[item.id] = (counts[item.id] || 0) + item.amount;
                }
            });

            document.querySelectorAll('.foodItem').forEach(el => {
                const id = el.getAttribute('id');
                const count = counts[id] || 0;

                // Update badge
                const badge = el.querySelector('.product-qty-badge');
                if (badge) {
                    badge.innerText = count;
                    badge.style.display = count > 0 ? 'flex' : 'none';
                }

                // Update Card UI (plus button vs qty control)
                const addBtn = el.querySelector('.addToCartBtn');
                const qtyCtrl = el.querySelector('.card-qty');
                const qtyVal = el.querySelector('.qty-val');

                if (addBtn && qtyCtrl) {
                    if (count > 0 && !el.classList.contains('custom-item')) {
                        addBtn.style.display = 'none';
                        qtyCtrl.style.display = 'flex';
                        if (qtyVal) qtyVal.innerText = count;
                    } else {
                        addBtn.style.display = 'flex';
                        qtyCtrl.style.display = 'none';
                    }
                }
            });
        }

        document.addEventListener('DOMContentLoaded', () => {
            setTimeout(syncProductBadges, 500); // Wait for cart initialization
        });

        function submitModalCart() {
            const productName = document.querySelector('.product-modal-popup h1').innerText;
            const notes = document.getElementById('product-notes')?.value || '';
            const item = {
                id: currentTriggeringProduct?.id || ('custom-' + Date.now()),
                name: productName,
                price: basePrice + addonsPrice,
                hasAddons: (addonsPrice > 0) || (notes.length > 0),
                notes: notes
            };

            if (window.cart) {
                window.cart.addItem(item, quantity);
            }

            Swal.close();
            Swal.fire({
                icon: 'success',
                title: '\u062a\u0645\u062a \u0627\u0644\u0625\u0636\u0627\u0641\u0629',
                timer: 1500,
                showConfirmButton: false
            });
        }

        function addUpsellItem(btn, price) {
            const wrapper = btn.closest('.upsell-img-wrapper');
            const qtyCtrl = wrapper.querySelector('.qty-control');
            const badge = wrapper.querySelector('.upsell-badge');

            btn.style.display = 'none';
            qtyCtrl.style.display = 'flex';
            if (badge) {
                badge.style.display = 'flex';
                badge.innerText = '1';
            }

            addonsPrice += price;
            updateModalTotal();
        }

        function updateUpsellQty(btn, delta, price) {
            const container = btn.closest('.qty-control');
            const valSpan = container.querySelector('.upsell-qty-val');
            let currentQty = parseInt(valSpan.innerText);

            const newQty = Math.max(0, currentQty + delta);
            valSpan.innerText = newQty;

            // Update modal price
            addonsPrice += (delta * price);
            updateModalTotal();

            if (newQty === 0) {
                const wrapper = btn.closest('.upsell-img-wrapper');
                wrapper.querySelector('.upsell-add-btn').style.display = 'flex';
                wrapper.querySelector('.upsell-badge').style.display = 'none';
                container.style.display = 'none';
                valSpan.innerText = 1; // Reset for next time
            } else {
                const wrapper = btn.closest('.upsell-img-wrapper');
                const badge = wrapper.querySelector('.upsell-badge');
                badge.innerText = newQty;
                badge.style.display = 'flex';
            }
        }

        window.onpopstate = function() {
            if (Swal.isVisible()) {
                Swal.close();
            }
        };

        function openSizesModal(el, name) { openProductModal(el, name); }

        function selectSwalSize(el) {
            document.querySelectorAll('.size-option').forEach(opt => opt.classList.remove('active'));
            el.classList.add('active');
        }        function toggleFavorite(event, element) {
            if (event) {
                event.preventDefault();
                event.stopPropagation();
            }

            const shopIdEl = document.getElementById('shopId');
            if (!shopIdEl) return;
            const shopId = shopIdEl.innerText.trim();
            const icon = element.querySelector('i');
            let favorites = JSON.parse(localStorage.getItem('favoriteShops') || '[]');
            const index = favorites.findIndex(f => String(f.id) === String(shopId));

            if (index === -1) {
                // Add to favorites
                const shopData = {
                    id: shopId,
                    name: document.querySelector('.shop-header-info h1')?.innerText.trim() || '',
                    photo: document.querySelector('.shop-header-img img')?.src || '',
                    desc: document.querySelector('.shopFoods')?.innerText.trim() || '',
                    descEn: '',
                    deliveryTime: document.querySelector('.timer')?.innerText.trim() || '',
                    deliveryCost: document.getElementById('deliveryCostValue')?.innerText.trim() || '',
                    rate: document.getElementById('rawRating')?.innerText.trim() || '',
                    isOpened: document.getElementById('isOpened')?.innerText.trim() || '',
                    url: window.location.href
                };
                favorites.push(shopData);
                element.classList.add('is-favorite');
                element.classList.add('active'); // For navbar icon
                if (icon) {
                    icon.classList.remove('fa-regular');
                    icon.classList.add('fa-solid');
                }
                element.classList.add('animate-twirl');
                setTimeout(() => element.classList.remove('animate-twirl'), 800);
            } else {
                // Remove from favorites
                favorites.splice(index, 1);
                element.classList.remove('is-favorite');
                element.classList.remove('active'); // For navbar icon
                if (icon) {
                    icon.classList.remove('fa-solid');
                    icon.classList.add('fa-regular');
                }
            }
            localStorage.setItem('favoriteShops', JSON.stringify(favorites));

            // Sync other heart (if any)
            syncAllHearts();
        }

        function syncAllHearts() {
            const shopIdEl = document.getElementById('shopId');
            if (!shopIdEl) return;
            const shopId = shopIdEl.innerText.trim();
            const favorites = JSON.parse(localStorage.getItem('favoriteShops') || '[]');
            const isFav = favorites.some(f => String(f.id) === String(shopId));

            const hearts = [
                document.getElementById('shopHeartIcon'),
                document.getElementById('favIconNav')
            ];

            hearts.forEach(heart => {
                if (!heart) return;
                const icon = heart.querySelector('i');
                if (isFav) {
                    heart.classList.add('is-favorite', 'active');
                    if (icon) { icon.classList.remove('fa-regular'); icon.classList.add('fa-solid'); }
                } else {
                    heart.classList.remove('is-favorite', 'active');
                    if (icon) { icon.classList.remove('fa-solid'); icon.classList.add('fa-regular'); }
                }
            });
        }

        function handleNavFavorite(event, btn) {
            toggleFavorite(event, btn);
        }

        function handleNavSearch(event) {
            event.preventDefault();
            const searchInput = document.getElementById('selectedShopSearcher');
            if (searchInput) {
                searchInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
                searchInput.focus();
            }
        }



        function initFavorites() {
            const shopIdEl = document.getElementById('shopId');
            if (!shopIdEl) return;
            const shopId = shopIdEl.innerText.trim();
            const favorites = JSON.parse(localStorage.getItem('favoriteShops') || '[]');
            const heart = document.getElementById('shopHeartIcon');
            if (!heart) return;
            const icon = heart.querySelector('i');

            if (favorites.some(f => String(f.id) === String(shopId))) {
                heart.classList.add('is-favorite');
                if (icon) {
                    icon.classList.remove('fa-regular');
                    icon.classList.add('fa-solid');
                }
            } else {
                heart.classList.remove('is-favorite');
                if (icon) {
                    icon.classList.remove('fa-solid');
                    icon.classList.add('fa-regular');
                }
            }
        }

        // Active Sidebar Styling logic with Scroll Spy
        function initSidebarActiveState() {
            const allLinks = document.querySelectorAll('.foodNavLinks a, .category-pill');
            const sections = document.querySelectorAll('.foodList');

            // Set initial active state based on hash or first item
            const hash = window.location.hash;
            if (hash) {
                const activeLink = document.querySelector(`.foodNavLinks a[href="${hash}"], .category-pill[href="${hash}"]`);
                if (activeLink) activeLink.classList.add('active');
            } else if (allLinks.length > 0) {
                allLinks[0].classList.add('active');
            }

            // Intersection Observer for Scroll Spy
            const observerOptions = {
                root: null,
                rootMargin: '-20% 0px -60% 0px',
                threshold: 0
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const id = entry.target.id;
                        if (!id) return;

                        allLinks.forEach(l => l.classList.remove('active'));

                        const targetLinks = document.querySelectorAll(`.foodNavLinks a[href="#${id}"], .category-pill[href="#${id}"]`);
                        targetLinks.forEach(link => link.classList.add('active'));

                        // Sync hash without jumping
                        if (id && history.pushState) {
                            history.pushState(null, null, '#' + id);
                        }
                    }
                });
            }, observerOptions);

            sections.forEach(section => observer.observe(section));

            allLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    // Manual override temporarily to prevent observer fight
                    allLinks.forEach(l => l.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        }

        document.addEventListener('DOMContentLoaded', () => {
            initFavorites();
            syncAllHearts(); // Update navbar icon too
            initSidebarActiveState();
        });
    </script>
    <style>
        .swal-sizes-container {
            display: flex;
            flex-direction: column;
            gap: 10px;
            text-align: right;
        }
        .size-option {
            display: flex;
            justify-content: space-between;
            padding: 12px 15px;
            border: 1px solid #eee;
            border-radius: 10px;
            cursor: pointer;
            transition: 0.2s;
        }
        .size-option:hover {
            background: #fdfdfd;
            border-color: #ffc119;
        }
        .size-option.active {
            background: #fffdf5;
            border-color: #ffc119;
            box-shadow: 0 0 0 1px #ffc119;
        }
        /* Sidebar active styling */
        #foodListsNav {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            border: 1px solid #eee;
            position: sticky;
            top: 140px;
        }

        #foodListsNav h3 {
            color: black;
            padding: 15px;
            margin: 0;
            font-size: 1.2rem;
            text-align: center;
            font-weight: 700;
        }

        .foodNavLinks {
            padding: 10px;
        }

        .foodNavLinks a {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 12px 15px;
            display: flex;
            align-items: center;
            border-radius: 8px;
            margin-bottom: 5px;
            color: #555;
            text-decoration: none;
            font-size: 0.95rem;
            border: 1px solid transparent;
        }

        .foodNavLinks a:hover {
            background: #fff9e6;
            color: #ffc119;
            transform: translateX(-5px);
        }

        .swal2-popup.product-modal-popup {
            border-radius: 16px !important;
            overflow: hidden;
        }

        .full-modal-container {
            width: 100%;
            height: auto;
            max-height: 90vh;
            padding: 0;
            display: flex;
            flex-direction: column;
            background: #fff;
            position: relative;
            text-align: right;
            direction: rtl;
        }

        .modal-banner {
            position: relative;
            width: 100%;
            height: 225px;
            background: #eee;
        }

        .modal-banner img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .modal-close-btn {
            position: absolute;
            top: 15px;
            left: 15px;
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            cursor: pointer;
            z-index: 10;
        }

        .modal-content-body {
            flex: 1;
            overflow-y: auto;
            overflow-x: hidden;
            padding: 20px;
            padding-bottom: 0px;
        }

        .modal-main-info h1 {
            font-size: 1.5rem;
            margin-bottom: 5px;
            font-weight: 700;
        }

        .modal-desc {
            color: #777;
            font-size: 0.9rem;
            margin-bottom: 25px;
            text-align: initial;
        }
        .swal2-container{
            padding: 0;
        }

        .modal-section {
            margin-bottom: 30px;
            textarea{
                width: 100%;
                background-color: #fffcfc;
                padding: 1rem;
                border-radius:1rem;
                resize: none;
                border-color: rgba(0, 0, 0, 0.1);
                height: 150px;
            }
        }


        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .section-header h3 {
            font-size: 1.1rem;
            font-weight: 700;
            margin: 0;
        }

        .required-badge {
            background: #fff3cd;
            color: #856404;
            font-size: 0.75rem;
            padding: 4px 8px;
            border-radius: 4px;
        }

        .optional-badge {
            background: #eee;
            color: #666;
            font-size: 0.75rem;
            padding: 4px 8px;
            border-radius: 4px;
        }

        /* Option Rows */
        .option-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #fffcfc;
            cursor: pointer;
        }

        .price-radio {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .radio-circle {
            width: 20px;
            height: 20px;
            border: 2px solid #ddd;
            border-radius: 50%;
            position: relative;
        }

        .option-row.active .radio-circle {
            border-color: #ffc119;
        }

        .option-row.active .radio-circle::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 10px;
            height: 10px;
            background: #ffc119;
            border-radius: 50%;
        }

        /* Swiper Quick Cards */
        .quick-choices-swiper {
            padding: 5px 0;
            display: flex;
        }

        .quick-choices-swiper .swiper-wrapper {
            align-items: stretch;
        }

        .quick-card {
            width: 200px !important;
            height: auto;
            background: white;
            border: 1px solid rgba(0,0,0,0.2);
            border-radius: 12px;
            padding: 15px;
            position: relative;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }

        .quick-card .check-box {
            margin-top: auto;
            align-self: flex-start;
        }

        .quick-card.active {
            border-color: #ffc119;
            background: #fffdf5;
        }

        .quick-card h4 {
            margin: 10px 0 5px;
            font-size: 0.95rem;
        }

        .quick-card-badge {
            font-size: 0.7rem;
            color: #e67e22;
            background: #fff3e0;
            padding: 2px 6px;
            border-radius: 4px;
            width: fit-content;
        }

        /* Extras List */
        .extra-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #fffcfc;
            cursor: pointer;
        }

        .check-box {
            width: 22px;
            height: 22px;
            border: 2px solid #ddd;
            border-radius: 4px;
            position: relative;
        }

        .extra-item.active .check-box, .quick-card.active .check-box {
            background: #ffc119;
            border-color: #ffc119;
        }

        .extra-item.active .check-box::after, .quick-card.active .check-box::after {
            content: '\f00c';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            color: white;
            font-size: 12px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        /* Sticky Footer */
        .modal-footer-sticky {
            position: sticky;
            bottom: 0;
            background: white;
            padding: 15px 20px;
            box-shadow: 0 -5px 20px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            z-index: 100;
        }

        .qty-control {
            display: flex;
            align-items: center;
            gap: 15px;
            background: #f8f9fa;
            padding: 5px 15px;
            border-radius: 30px;
            border: 1px solid #eee;
        }

        .qty-control button {
            background: none;
            border: none;
            color: #ffc119;
            font-size: 1.1rem;
            cursor: pointer;
        }

        .add-to-cart-big {
            background: #ffc119;
            color: white;
            border: none;
            border-radius: 30px;
            padding: 12px 25px;
            display: flex;
            justify-content: center;
            gap: 20px;
            align-items: center;
            font-weight: 700;
            cursor: pointer;
            white-space: nowrap;
        }

        /* Upsell Cards */
        .related-products-swiper {
            padding: 10px 0;
        }

.swiper-wrapper:has(.upsell-card){
    max-height: 220px;
}
        .upsell-card img {
            width: 100%;
            height: 100px;
            object-fit: cover;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;

        }
        .upsell-card {
            width: 200px !important;
            background: white;
            border: 1px solid #eee;
            border-radius: 12px;
            max-height: 220px;
            text-align: center;
            padding-bottom: 15px;
            height: 100%; /* Equal height */
            display: flex;
            flex-direction: column;
        }

        .upsell-card h5 {
            margin: 10px 10px 5px;
            font-size: 0.9rem;
            flex-grow: 1; /* Push button to bottom */
        }

        /* Swiper Slide Equal Height Fix */
        .swiper-wrapper {
            display: flex !important;
            align-items: stretch !important;
            touch-action: pan-y !important;
        }

        .swiper-slide {
            height: auto !important;
        }

        .quick-card {
            background: white;
            border: 1px solid  rgba(0,0,0,0.2);
            border-radius: 12px;
            padding: 15px;
            text-align: center;
            width: 200px !important;
            cursor: pointer;
            transition: all 0.2s;
            position: relative;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .upsell-card p {
            color: #ffc119;
            font-weight: 700;
            font-size: 0.85rem;
            margin-bottom: 10px;
        }

        .upsell-card button {
            background: #fff9e6;
            color: #ffc119;
            border: 1px solid #ffc119;
            border-radius: 20px;
            padding: 5px 20px;
            margin-inline: 0.5rem;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .upsell-card button:hover {
            background: #ffc119;
            color: white;
        }

        /* Quantity Badge on Product Grid */
        .product-qty-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #ffc119;
            color: white;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: none; /* Hidden by default */
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
            font-weight: 700;
            box-shadow: 0 2px 8px rgba(255,193,25,0.4);
            z-index: 5;
            border: 2px solid white;
        }

        /* Upsell Quantity Control */
        .upsell-qty-container {
            display: none; /* Shown when item is added */
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 5px;
        }

        .upsell-qty-btn {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            border: 1px solid #ffc119;
            background: white;
            color: #ffc119;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            cursor: pointer;
        }

        .upsell-qty-btn:hover {
            background: #ffc119;
            color: white;
        }

        .upsell-qty-val {
            font-size: 0.9rem;
            font-weight: 700;
            min-width: 15px;
            color: #333;
        }

        .upsell-remove-btn {
            color: #ff4d4d;
            font-size: 0.75rem;
            cursor: pointer;
            margin-top: 5px;
            display: block;
            text-decoration: underline;
        }

        /* Fix Swiper scroll blocking */
        .swiper-wrapper {
            touch-action: pan-y !important;
        }

        .related-products-swiper {
            overflow: visible !important;
        }

        /* User Edit Fix: Empty Cart Margin */
        #emptyCart {
            margin-bottom: 0px !important;
        }

        /* Shop Pay Methods Badges */
        .shopPayMethods {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .pay-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            padding: 6px 10px;
            border-radius: 50px;
            font-size: 0.6rem;
            font-weight: 700;
            border: 1px solid transparent;
            transition: transform 0.2s;
            margin: 0;
        }

        .pay-badge i {
            font-size: 0.65rem;
        }

        /* Accent Colors */
        .pay-badge.tracking {
            color: #4361ee;
            background: #f0f3ff;
            border-color: #dbeafe;
        }

        .pay-badge.safe {
            color: #06d6a0;
            background: #e7fbf5;
            border-color: #cbf6eb;
        }

        .pay-badge.free {
            color: #ff2d55; /* Bright Pink Accent */
            background: #fff5f7;
            border-color: #ffe0e5;
        }

        .shopDelivery {
            display: flex;
            flex-wrap: wrap;
            color: #666;
        }

        .shopDelivery span {
            display: flex;
            align-items: center;
            gap: 3px;
            font-weight: 500;
        }



        /* Mobile Full Screen Modal */
        @media (max-width: 600px) {
            #shopBanner {
                height: 250px !important;
}
            .swal2-container:has(.product-modal-popup) {
                padding: 0 !important;
            }
            .swal2-popup.product-modal-popup {
                width: 100vw !important;
                max-width: 100vw !important;
                height: 100vh !important;
                max-height: 100vh !important;
                border-radius: 0 !important;
                margin: 0 !important;
            }
            .full-modal-container {
                height: 100vh !important;
                max-height: 100vh !important;
            }
        }
    </style>
    </asp:Content>
