<%@ Page Title="" Language="C#" MasterPageFile="~/Ar/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="POrders.aspx.cs" Inherits="Ar_POrders" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" Runat="Server">
<asp:Literal runat="server" Text="<%$ Resources:texts, PageOtitle %>" />
    </asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <section id="userDashboard">
    <div class="userProfileField">
 <span class="route">
                <a href="default.aspx"><asp:Literal runat="server" Text="<%$ Resources:texts, Home %>" /></a>
                <i class="fa-solid fa-angles-left"></i>
                <asp:Literal ID="litMyAccount2" runat="server" Text="<%$ Resources:texts, MyAccount %>" />
            </span>
     <div class="profile-head">
                <asp:Literal ID="litMyAccount" runat="server" Text="<%$ Resources:texts, MyAccount %>"></asp:Literal>
                <i id="dropDownBtn" class="fa-solid fa-angles-down"></i>
            </div>
      <article class="profileContainer">
           <ul class="profileSettings">
                <li><a href="profile.aspx"><asp:Literal ID="litAccountInfo" runat="server" Text="<%$ Resources: texts, AccountInfo %>"></asp:Literal></a></li>
                <li><a href="Addresses.aspx"><asp:Literal ID="litAddresses" runat="server" Text="<%$ Resources: texts, Addresses %>"></asp:Literal></a></li>
                <li class="active"><a href="POrders.aspx"><asp:Literal ID="litOrders" runat="server" Text="<%$ Resources: texts, Orders %>"></asp:Literal></a></li>
            </ul>

        <article class="orderHistory">
            <div id="noPreviousOrders" runat="server" visible="false">
    <i class="fa-solid fa-cart-shopping"></i>
    <p><asp:Literal runat="server" Text="<%$ Resources:texts, NoOrders %>" /></p>
</div>

<div class="orderDates">
  <h2><asp:Literal runat="server" Text="<%$ Resources:texts, Orecords %>" />
</h2>
  <div class="dateFilters">
    <span><asp:Literal runat="server" Text="<%$ Resources:texts, Today %>" /></span>
    <span><asp:Literal runat="server" Text="<%$ Resources:texts, Yesterday %>" /></span>
    <span><asp:Literal runat="server" Text="<%$ Resources:texts, Last7 %>" /></span>
    <span><asp:Literal runat="server" Text="<%$ Resources:texts, LastMonth %>" /></span>
    <span><asp:Literal runat="server" Text="<%$ Resources:texts, LastYear %>" /></span>
  </div>

  <!-- اليوم -->
  <asp:Repeater ID="rptOrders" runat="server">
    <HeaderTemplate>
        <figure class="filteredDateOrders">
            <h3><asp:Literal runat="server" Text="<%$ Resources:texts, Today %>" /></h3>
            <div class="ordersHolder">
    </HeaderTemplate>
    <ItemTemplate>
        <article class="previousOrder">
            <div class="previousOrderDetails">
                <h3 class="shopName"><%#System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName == "en" 
        ? DataBinder.Eval(Container.DataItem, "PlaceNameEn") 
        : System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName == "ru"
          ? DataBinder.Eval(Container.DataItem, "PlaceNameRu")
          : DataBinder.Eval(Container.DataItem, "PlaceName")
    %></h3>
                <p class="orderedItem"><%# Eval("OrderedItems") %></p>
                <p class="deliveryLocation"><asp:Literal ID="litAccountInfo" runat="server" Text="<%$ Resources: texts, Address %>"></asp:Literal>: <%# Eval("AddressName") %></p>
            </div>
            <div class="previousOrderDetails">
                <h3 class="orderedItemPrice"><%# Eval("TotalPrice") %> <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources: texts, Currency %>"></asp:Literal></h3>
                <p class="orderDate"><%# Convert.ToDateTime(Eval("Odate")).ToString("dddd — yyyy/MM/dd") %></p>
            </div>
        </article>
    </ItemTemplate>

    <FooterTemplate>
            </div>
        </figure>
    </FooterTemplate>
</asp:Repeater>


        </article>

      </article>
    </div>
  </section>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageScripts" Runat="Server">
    <style>
    /* user profile styles */
section#userDashboard {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-inline: 25px;
}
.userProfileField {
  padding: 25px;
  padding-top: 120px;
  margin-bottom: 25px;
  max-width: 1024px;
  width: 100%;
  margin-inline: auto;
  box-shadow: var(--shadow);
  border-radius: 0.5rem;
}
.profile-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 2rem;
  font-weight: bold;
  i {
    cursor: pointer;
    font-size: 1.75rem;
    transition: 0.5s all ease;
    display: none;
    &:hover {
      color: var(--fd-blue);
      rotate: 180deg;
    }
  }
}

.profile-head.active {
  i {
    rotate: 180deg;
    color: var(--fd-blue);
  }
}

.profileContainer {
  position: relative;
  isolation: isolate;
  display: grid;
  grid-template-columns: 20% 80%;
  margin-top: 20px;
  padding: 25px 0px;
  border-top: 1px solid rgba(0, 0, 0, 0.2);
}

.profileSettings {
  list-style-type: none;
  border-left: 1px solid rgba(0, 0, 0, 0.2);
  height: fit-content;
  position: sticky;
  top: 100px;


  li {
    padding: 10px;
    transition: 0.3s color ease;
    &:hover {
      a {
        color: var(--fd-blue);
      }
    }
    a {
      transition: inherit;
    }
  }
}

.profileSettings li.active {
  a {
    color: var(--fd-blue);
  }
  border-right: 2px solid var(--fd-blue);
}

.profileContainer form {
  padding-block: 10px;
  padding-right: 25px;
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
  input {
    border-radius: 0.25rem;
    border: 1px solid rgba(0, 0, 0, 0.25);
    padding: 0.2rem 1rem;
    width: 100%;
    max-width: 300px;
    background-color: transparent;
    font-size: 0.9rem;
  }
  label,
  button {
    white-space: nowrap;
  }
  label {
    min-width: 113px;
  }
  button {
    border-radius: 2rem;
    padding: 0.5rem 1rem;
    font-size: 0.75rem;
    border: 1px solid rgba(0, 0, 0, 0.25);
    background-color: transparent;
    transition: var(--transition);
    font-weight: bold;
    &:hover {
      background-color: var(--fd-blue);
      color: white;
      border-color: transparent;
    }
  }

  .service_subscribe {
    width: fit-content;
    display: flex;
    align-items: center;
    gap: 1rem;

  }
}


.editBtns {
  align-items: center;
  flex-wrap: wrap;
  display: flex;
  gap: 1rem;
}

.gender-btn {
  padding: 10px 68px;
  border: 1px solid #ccc;
  cursor: pointer;
  user-select: none;
  transition: all 0.2s;
  border-top-right-radius: 8px;
  border-bottom-right-radius: 8px;
}
.gender-btn:last-child {
  border-radius: 0;
  border-top-left-radius: 8px;
  border-bottom-left-radius: 8px;
}

.gender-btn:hover {
  background-color: #f0f0f0;
}

input[type="radio"]:checked + label {
  background-color: var(--fd-blue);
  color: white;
  border-color: var(--fd-blue);
}

input[type="radio"] {
  width: 150px;
}

.birthday {
  position: relative;
  isolation: isolate;
  width: 100%;
  max-width: 300px;
  svg {
    position: absolute;
    left: 0.5rem;
    top: 0.5rem;
    width: 16px;
  }
}

.inputHolder {
  position: relative;
  width: 100%;
  border-radius: 0.25rem;
  max-width: 300px;
  isolation: isolate;
  background-color: #e9ecef;
  overflow: hidden;
  input {
    cursor: not-allowed;
    color: rgb(74, 71, 71);
    &:focus {
      outline: none;
    }
  }
}

.labelTag {
  font-size: 1.5rem;
  color: var(--fd-blue);
}

.dataField {
  display: flex;
  flex-wrap: wrap;
  align-items: baseline;
  gap: 1rem;
}

#noPreviousOrders {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  gap: 0.5rem;
  font-size: 1.25rem;
  min-height: 300px;
  color: #777;
  i {
    font-size: 6rem;
    position: relative;
  }
  i::after {
    content: "";
    border-radius: 8px;
    rotate: 45deg;
    inset: 0;
    top: -8px;
    margin: auto;
    width: 10px;
    height: calc(100% + 56px);
    background: linear-gradient(to right, #777 50%, white 50%);
    position: absolute;
  }
  button {
    background-color: var(--fd-blue);
    color: white;
    padding: 0.5rem 1rem;
    outline: 0;
    font-size: 1rem;
    border: 2px solid transparent;
    border-radius: 0.5rem;
    transition: var(--transition);
    &:hover {
      background-color: transparent;
      color: var(--fd-blue);
      border-color: currentColor;
    }
  }
}
#locationFormShower {
  width: 100%;
  position: absolute;
  display: none;
  interpolate-size: allow-keywords;
  top: 60px;
  left: 0;
  flex-direction: column;
  z-index: -1000;
  opacity: 0;
  pointer-events: none;
  visibility: hidden;
  transition: var(--transition);
}

#locationFormShower.is-visible {
  z-index: 10000;
  display: flex;
  opacity: 1;
  pointer-events: auto;
  visibility: visible;
}

#map-shower.hidden {
  z-index: -1000;
  opacity: 0;
  pointer-events: none;
  visibility: hidden;
}

.addLocationBtn {
  margin-block: 1rem;
  margin-inline: auto;
  display: flex;
  justify-content: center;
  align-items: baseline;
  gap: 0.5rem;
  font-size: 1.125rem;
  padding: 0.25rem 1.5rem;
  border-radius: 0.5rem;
  border: 2px solid #0056b3;
  transition: var(--transition);
  background-color: #0056b3;
  color: white;
  &:hover {
    background-color: transparent;
    color: #0056b3;
  }
}
.user-location {
  padding-right: 20px;
  padding-block: 20px;
}
.user-location:nth-child(even) {
  background-color: whitesmoke;
}

.editLocationBtn {
  margin-top: 0.5rem;

  padding: 0.25rem 1.5rem;
  border-radius: 0.5rem;
  border: 2px solid var(--fd-blue);
  transition: var(--transition);
  background-color: var(--fd-blue);
  color: white;
  &:hover {
    background-color: transparent;
    color: var(--fd-blue);
  }
}

.deleteLocationBtn {
  margin-top: 0.5rem;
  padding: 0.25rem 1.5rem;
  border-radius: 0.5rem;
  border: 2px solid var(--fd-red);
  transition: var(--transition);
  background-color: var(--fd-red);
  color: white;
  &:hover {
    background-color: transparent;
    color: var(--fd-red);
  }
}

.hidden {
  display: none;
}

.orderHistory{
  padding: 1rem;
  overflow: hidden;
}
.dateFilters{
  display: flex;
  gap: 1rem;
    overflow-x: auto;
  scroll-behavior: smooth;
  -webkit-overflow-scrolling: touch;
  cursor: grab;
  padding: 0.5rem 0rem;
  user-select: none;
  align-items: center;
  span{
    border-radius: 2rem;
    border: 1px solid rgba(0, 0, 0, 0.25);
    padding: 0.25rem 1rem;
    cursor: pointer;
    transition: var(--transition);
    white-space: nowrap;
    &:hover{
        background-color: var(--fd-blue);
    border-color: transparent;
    color: white;
  }

  }
  span.active{
    background-color: var(--fd-blue);
    border-color: transparent;
    color: white;
  }
}
.dateFilters.active{
  cursor: grabbing;
}

.dateFilters::-webkit-scrollbar{
  height: 0;
}

.ordersHolder{
  display: flex;
  flex-direction: column;
}

.previousOrder{
  display: flex; justify-content: space-between;
  align-items: center;
  padding: 1rem;
  gap: 1rem;
  flex-wrap: wrap;
border-radius: 0.25rem;

}
.previousOrder:nth-child(odd){
  background-color: whitesmoke;
}

.orderDates{
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.filteredDateOrders{
  margin-top: 1rem;
  border-bottom: 1px solid rgba(0, 0, 0, 0.125);
  padding-bottom: 1rem;
}
.header {
   
    background: linear-gradient(135deg, #fffbe6 0%, #ffffff 0%, #fffbe6 10%) !important;
  
}
  </style>
</asp:Content>

