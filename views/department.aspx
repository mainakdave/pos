<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="department.aspx.cs" Inherits="SimpleImageUpload_UserControl_WebApp_CS.views.department" MasterPageFile="~/views/masterPage.Master" %>

<%@ Register src="~/piczardUserControls/simpleImageUploadUserControl/SimpleImageUpload.ascx" tagname="SimpleImageUpload" tagprefix="ccPiczardUC" %>




<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript">
        $(document).ready(function () {

            var IU = 'I';
            var ID = -1;
            var isDelete = false;

            $("#btnCancel").click(function () {
                $(".alert").alert();
                clearAllElements();
                return false;
            });



            $("#submit").click(function () {

                //$("#<%=Button1.ClientID %>").click();

                if (window.IU == 'I') {
                    var bgColor = $("#colorSelector > div").css("background-color");
                    var textColor = $("#colorSelector_text > div").css("background-color");


                    $.post("../Ajax/department.aspx",
                        {
                            deptName: $("#deptName").val(),
                            description: $("#description").val(),
                            image: "dept0",
                            bgColor: bgColor,
                            textColor: textColor,
                            costCenter: $("#costCenter").val(),
                            saleAcct: $("#saleAcct").val(),
                            purchaseAcct: $("#purchaseAcct").val(),
                            createDate: '',
                            createUser: '-1',
                            modifyUser: '-1',
                            StatementType: 'Insert'
                        },

                        function (response) {
                            //alert(response);
                            //PageMethods.SendForm(response);
                            PageMethods.saveImage(response);

                            alert("Data inserted...");
                        }
                    );

                    return false;
                }
                else {
                    var bgColor = $("#colorSelector > div").css("background-color");
                    var textColor = $("#colorSelector_text > div").css("background-color");


                    $.post("../Ajax/department.aspx",
                        {
                            deptID: window.ID,
                            deptName: $("#deptName").val(),
                            description: $("#description").val(),
                            image: "dept" + window.ID,
                            bgColor: bgColor,
                            textColor: textColor,
                            costCenter: $("#costCenter").val(),
                            saleAcct: $("#saleAcct").val(),
                            purchaseAcct: $("#purchaseAcct").val(),
                            modifyUser: '-1',
                            StatementType: 'Update'
                        },

                        function (response) {
                            //alert(response);
                            //PageMethods.SendForm(response);
                            PageMethods.saveImage(window.ID);
                            window.IU = 'I';

                            alert("Data updated...");
                        }
                    );

                    return false;
                }
            });


        });


        function updateRow(id, deptName, description, bgColor, textColor, costCenter, saleAcct, purchaseAcct) {
            if (!window.isDelete) {
                //alert(id);
                //$("#deptName").val(id);
                window.IU = 'U';
                window.ID = id;

                $("#deptName").val(deptName);
                $("#description").val(description);
                $("#colorSelector > div").css("background-color", bgColor);
                $("#colorSelector_text > div").css("background-color", textColor);
                $("#costCenter").val(costCenter);
                $("#saleAcct").val(saleAcct);
                $("#purchaseAcct").val(purchaseAcct);
                //PageMethods.updateRow(id);
            }
        }


        function deleteRow(id) {
            window.isDelete = true;

            if (confirm('Sure To Delete?')) {
                $.post("../Ajax/department.aspx",
                    {
                        deptID: window.ID,
                        StatementType: 'Delete'
                    },

                    function (response) {
                        //alert(response);
                        //PageMethods.SendForm(response);
                        //PageMethods.saveImage(window.ID);

                        alert("Data deleted...");
                    }
                );
            } else {
                // Do nothing!
            }

            clearAllElements();
            return false;
        }

        function clearAllElements() {
            window.IU = 'I';
            window.ID = -1;
            window.isDelete = false;

            $("#deptName").val(null);
            $("#description").val(null);
            $("#colorSelector > div").css("background-color", "transparent");
            $("#colorSelector_text > div").css("background-color", "transparent");
            $("#costCenter").val(null);
            $("#saleAcct").val(null);
            $("#purchaseAcct").val(null);

            
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div class="navbar">
        <div class="navbar-inner">
            <ul class="nav">
                <li class="active"><a href="#">Department</a></li>
                <li class="divider-vertical"></li>
                <li><a href="#">Section</a></li>
                <li class="divider-vertical"></li>
                <li><a href="#">Family</a></li>
            </ul>
            </div>
    </div>

        <div class="row-fluid">
            <div class="span6">
                <form class="navbar-form pull-left" id="departmentForm">

            <asp:ScriptManager runat="server" ID="ScriptManager1" EnablePageMethods="true">
                            </asp:ScriptManager>  

            <div id="department">
                <table>
                    <tr>
                        <td><label>Department Name</label></td>
                        <td><input id="deptName" type="text" placeholder="Department Name" class="span2"></td>
                    </tr>

                    <tr>
                        <td><label>Description</label></td>
                        <td><input id="description" type="text" placeholder="Description" class="span2"></td>
                    </tr>

                    <tr>
                        <td><labeImage</label></td>
                        <td>

                                      


                            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                <ContentTemplate>
        
                                <div class="pageContainer">  
                           
                                    <ccPiczardUC:SimpleImageUpload ID="ImageUpload1" runat="server" 
                                        Width="500px"
                                        AutoOpenImageEditPopupAfterUpload="true"
                                        Culture="en" OnImageUpload="onImageUpload"
                                     />
                
                
                                </div>
            
                                </ContentTemplate>
                            </asp:UpdatePanel>
    
                            
                        </td>
                    </tr>

                    <tr>
                        <td><label>Background Coloror</label></td>
                        <td><div id="colorSelector"><div></div></div></td>
                    </tr>

                    <tr>
                        <td><label>Text Color</label></td>
                        <td><div id="colorSelector_text"><div></div></div></td>
                    </tr>

                    <tr>
                        <td><label>Cost Center</label></td>
                        <td><input id="costCenter" type="text" placeholder="Cost Center" class="span2"></td>
                    </tr>

                    <tr>
                        <td><label>Sale Acct</label></td>
                        <td><input id="saleAcct" type="text" placeholder="Sale Acct" class="span2"></td>
                    </tr>

                    <tr>
                        <td><label>Purchase Acct</label></td>
                        <td><input id="purchaseAcct" type="text" placeholder="Purchase Acct" class="span2"></td>
                    </tr>

                    <tr>
                        <td></td>
                        <td><button id="submit" type="submit" class="btn" >Submit</button>
                            <asp:Button ID="Button1" runat="server" class="btn" Text="Button" onclick="Button1_Click" Visible="false"/>
                            <div id="btnCancel" class="btn" data-dismiss="alert">Cancel</div>
                            <a class="close" data-dismiss="alert" href="#">&times;</a>
                        </td>
                    </tr>                  
                                   <!-- Item Name -->
                </table>
            
                 
            
                

                
            
                <!-- Item Image -->
           </div>

                    

        </form>
            </div>

            <div class="span6">
                    <asp:Panel ScrollBars="Vertical" Height="300" runat="server">
                        <asp:ListView ID="lstvDept" runat="server" 
            onselectedindexchanged="lstvDept_SelectedIndexChanged">
            <LayoutTemplate >
                <table class="table table-condensed">
                    <tr><td style="background:#00ffff; font-size:medium">Department Name List</td></tr>
                    <tr>
                        <td><asp:PlaceHolder id="itemPlaceholder" runat="server" /></td>
                    </tr>
                </table>
            </LayoutTemplate>

            <ItemTemplate>
                <tr onmouseup="updateRow(<%#Eval("deptID") %>, '<%#Eval("deptName") %>', '<%#Eval("description ") %>', '<%#Eval("bgColor") %>', '<%#Eval("textColor") %>', '<%#Eval("costCenter") %>', '<%#Eval("saleAcct") %>', '<%#Eval("purchaseAcct") %>') ;">
                    <td>
                        <asp:Label ID="Label1" runat="Server" Text='<%#Eval("deptID") %>' />
                    </td>

                    <td>
                        <asp:Label ID="FirstNameLabel" runat="Server" Text='<%#Eval("deptName") %>' />
                    </td>

                    <td class="btn btn-danger btn-mini"  onmouseup="deleteRow(<%#Eval("deptID") %>)" style="cursor:pointer">Delete</td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
                    </asp:Panel>
            </div>
        </div>
                    
        
                
                 
        
       
                


        
       
        

        
</asp:Content>
