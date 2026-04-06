<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="MenuItems.aspx.cs" Inherits="Admin_Pages_MenuItems" Title="عناصر القوائم" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphead" Runat="Server">
    عناصر القوائم
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="100" DynamicLayout="true">
    <ProgressTemplate>
        <div class="update"></div>
    </ProgressTemplate>
</asp:UpdateProgress>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>

        <div class="page-bar">
            <div class="page-title-breadcrumb">
                <div class="pull-right">
                    <div class="page-title">تسجيل عناصر القوائم</div>
                </div>
                <ol class="breadcrumb page-breadcrumb pull-left">
                    <li><i class="fa fa-home"></i>&nbsp;<a class="parent-item" href="#">البيانات الأساسية</a>&nbsp;<i class="fa fa-angle-left"></i></li>
                    <li class="active">تسجيل عناصر القوائم</li>
                </ol>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="card card-box">
                    <div class="card-head">
                        <header>بيانات العنصر</header>
                        <div class="tools">
                            <a class="fa fa-repeat btn-color box-refresh" href="javascript:;"></a>
                            <a class="t-collapse btn-color fa fa-chevron-down" href="javascript:;"></a>
                            <a class="t-close btn-color fa fa-times" href="javascript:;"></a>
                        </div>
                    </div>

                    <div class="card-body" id="bar-parent">
                        <div class="form-body">


                                <!-- المكان / المطعم -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2">المكان / المطعم<span class="required">*</span></label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlPlace" runat="server" CssClass="form-control input-height" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlPlace_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvPlace" runat="server" ControlToValidate="ddlPlace"
                                        InitialValue="0" ErrorMessage="المكان مطلوبة" Display="Dynamic" CssClass="text-danger"
                                        ValidationGroup="MenuItemGroup" />
                                </div>
                            </div>

                            <!-- القائمة -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2">القائمة<span class="required">*</span></label>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlMenu" runat="server" CssClass="form-control input-height" AppendDataBoundItems="true">
                                       
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvMenu" runat="server" ControlToValidate="ddlMenu"
                                        InitialValue="0" ErrorMessage="القائمة مطلوبة" Display="Dynamic" CssClass="text-danger"
                                        ValidationGroup="MenuItemGroup" />
                                </div>
                            </div>

                        

                            <!-- اسم العنصر -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2">اسم العنصر<span class="required">*</span></label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control input-height"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                        ErrorMessage="اسم العنصر مطلوب" Display="Dynamic" CssClass="text-danger"
                                        ValidationGroup="MenuItemGroup" />
                                </div>
                            </div>
                              <div class="form-group row">
                                <label class="control-label col-sm-2">اسم العنصر بالإنجليزية<span class="required">*</span></label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtNameEn" runat="server" CssClass="form-control input-height"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNameEn"
                                        ErrorMessage="اسم العنصر بالإنجليزية مطلوب" Display="Dynamic" CssClass="text-danger"
                                        ValidationGroup="MenuItemGroup" />
                                </div>
                            </div>
                              <div class="form-group row">
                                <label class="control-label col-sm-2">اسم العنصر بالروسية<span class="required">*</span></label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtNameRu" runat="server" CssClass="form-control input-height"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNameRu"
                                        ErrorMessage="اسم العنصر بالروسية مطلوب" Display="Dynamic" CssClass="text-danger"
                                        ValidationGroup="MenuItemGroup" />
                                </div>
                            </div>
                            <!-- الوصف -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2">الوصف بالعربية</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control input-height"></asp:TextBox>
                                </div>
                            </div>
                             <div class="form-group row">
                                <label class="control-label col-sm-2">الوصف بالإنجليزية</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtDescriptionEn" runat="server" CssClass="form-control input-height"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-sm-2">الوصف بالروسية</label>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtDescriptionRu" runat="server" CssClass="form-control input-height"></asp:TextBox>
                                </div>
                            </div>
                            <!-- السعر والخصم -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2">السعر<span class="required">*</span></label>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control input-height"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice"
                                        ErrorMessage="السعر مطلوب" Display="Dynamic" CssClass="text-danger"
                                        ValidationGroup="MenuItemGroup" />
                                    <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice"
                                        ValidationExpression="^\d+(\.\d{1,2})?$" ErrorMessage="السعر يجب أن يكون رقم عشري"
                                        Display="Dynamic" CssClass="text-danger" ValidationGroup="MenuItemGroup" />
                                </div>

                                <label class="control-label col-sm-2">قيمة الخصم</label>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtDiscount" runat="server" CssClass="form-control input-height"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDiscount"
                                        ErrorMessage="الخصم مطلوب" Display="Dynamic" CssClass="text-danger"
                                        ValidationGroup="MenuItemGroup" />
                                    <asp:RegularExpressionValidator ID="revDiscount" runat="server" ControlToValidate="txtDiscount"
                                        ValidationExpression="^\d+(\.\d{1,2})?$" ErrorMessage="الخصم يجب أن يكون رقم عشري"
                                        Display="Dynamic" CssClass="text-danger" ValidationGroup="MenuItemGroup" />
                                </div>
                            </div>

                            <!-- الصورة -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2">الصورة</label>
                                <div class="col-md-8">
                                    <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                                <asp:HiddenField ID="hfPhotoPath" runat="server" />
                                </div>
                            </div>

                            <!-- متاح؟ -->
                            <div class="form-group row">
                                 <label class="control-label col-sm-2">متاح</label>
                                 <div class="col-md-2">
                                <label class="switchToggle">
                                                     <asp:CheckBox ID="chkAvailable" runat="server" Checked="true" />
                                                <span class="slider green round"></span>
                                            </label>
                                     </div>
                            </div>

                            <!-- الأزرار -->
                            <div class="col-lg-12 p-t-5 text-center">
                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-info m-r-20" Text="حفظ"
                                    OnClick="btnSave_Click" ValidationGroup="MenuItemGroup" />
                                <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="الغاء"
                                    OnClick="btnCancel_Click" CausesValidation="false" />
                            </div>

                            <!-- البحث -->
                            <div class="form-group row p-t-10">
                                <div class="col-md-5">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" Text="بحث" OnClick="btnSearch_Click" CausesValidation="false" />
                                    </div>
                                </div>
                            </div>

                            <!-- GridView -->
                            <div class="table-scrollable">
                                <asp:GridView ID="gvMenuItems" runat="server" AutoGenerateColumns="False" 
                                    CssClass="table table-striped table-bordered table-hover" AllowPaging="True" PageSize="10"
                                    OnPageIndexChanging="gvMenuItems_PageIndexChanging" OnRowCommand="gvMenuItems_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="الصورة">
                                            <ItemTemplate>
                                                <asp:Image ID="imgPhoto" runat="server" Width="50px" Height="50px" 
                                                    ImageUrl='<%# "~/ar/" + Eval("PhotoUrl") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="الاسم" DataField="Name" />
                                        <asp:BoundField HeaderText="الإسم بالإنجليزية" DataField="NameEn" />
                                        <asp:BoundField HeaderText="الإسم بالروسية" DataField="NameRu" />
                                        <asp:BoundField HeaderText="المكان" DataField="PlaceName" />
                                        <asp:BoundField HeaderText="القائمة" DataField="MenuName" />
                                        <asp:BoundField HeaderText="السعر" DataField="Price" DataFormatString="{0:N2}" />
                                        <asp:BoundField HeaderText="الخصم" DataField="DiscountValue" DataFormatString="{0:N2}" />
                                        <asp:TemplateField HeaderText="متاح؟">
                                            <ItemTemplate>
                                                <%# (bool)Eval("IsAvailable") ? "نعم" : "لا" %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        <asp:TemplateField HeaderText="التحكم">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbEdit" runat="server" CommandName="EditItem" CommandArgument='<%# Eval("ID") %>'
                                                    CssClass="btn btn-xs btn-info">تعديل</asp:LinkButton>
                                                &nbsp;
                                                <asp:LinkButton ID="lbDelete" runat="server" CommandName="DeleteItem" CommandArgument='<%# Eval("ID") %>'
                                                    OnClientClick="return confirm('هل أنت متأكد من الحذف؟');" CssClass="btn btn-xs btn-danger">حذف</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>

    </ContentTemplate>
     <Triggers>
        <asp:PostBackTrigger ControlID="btnSave" />
    </Triggers>
</asp:UpdatePanel>

</asp:Content>
