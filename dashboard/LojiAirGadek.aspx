<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LojiAirGadek.aspx.cs" Inherits="dashboard_LojiAirGadek" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>SAMB| Loji Air Gadek</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
        name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="~/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="~/plugins/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="~/plugins/ionicons.min.css">
    <!-- daterange picker -->
    <link rel="stylesheet" href="~/plugins/daterangepicker/daterangepicker-bs3.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="~/plugins/iCheck/all.css">
    <!-- Bootstrap time Picker -->
    <link rel="stylesheet" href="~/plugins/timepicker/bootstrap-timepicker.min.css">
    <!-- Bootstrap Color Picker -->
    <link rel="stylesheet" href="~/plugins/colorpicker/bootstrap-colorpicker.min.css">
    <!-- Bootstrap Date Picker -->
    <link rel="stylesheet" href="~/plugins/datepicker/datepicker3.css">
    <!-- bootstrap slider -->
    <link rel="stylesheet" href="~/plugins/bootstrap-slider/slider.css">
    <!-- Select2 -->
    <link rel="stylesheet" href="~/plugins/select2/select2.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="~/plugins/datatables/dataTables.bootstrap.css">
    <!-- ion slider Nice -->
    <link rel="stylesheet" href="~/plugins/ionslider/ion.rangeSlider.css">
    <link rel="stylesheet" href="~/plugins/ionslider/ion.rangeSlider.skinHTML5.css">
    <link rel="stylesheet" href="~/dist/css/AdminLTE.min.css">
    <link href="~/dist/css/dashboard-retail.css" rel="stylesheet">
    <link href="~/dist/css/horizBarChart.css" rel="stylesheet">
    <link href="~/dist/css/formValidation.css" rel="stylesheet">
    <%--<link href="../../dist/css/components.css" rel="stylesheet">--%>
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="~/dist/css/skins/skin-blue.css">
    <link rel="stylesheet" href="~/dist/css/skins/skin-blue.min.css">
    <style type="text/css">
        .icon {
            top: -25px !important;
            right: 30px !important;
        }
        .content {
            min-height: 850px;
        }
        th{ 
            background-color: #0071bb;  
            font-size: 11px; 
        }
        a{ 
            padding-left:20px;
            color: white; 
        }
    </style>
    <script type ="text/javascript">
          
        function showpage(page)
        { 
            document.getElementById('frmshow').src = "../custom/" + page + ".aspx";
        }
    </script>
</head>
<body>
    <div class="content-wrapper" style="margin-left: 0px;">
         <section class="content-header">
            <h1>Loji Air Gadek
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i>Loji Air Gadek</a></li>
            </ol>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-md-2" style ="padding-right:0px;padding-left:0px;">
                    <div class="box box-info  box-solid" style="background-color: #ffffff;">
                        <div class="box-body" style="padding:2px;">
                            <table class="table table-condensed"  >
                                <tbody>
                                     <tr>
                                        <th><h3 style="color:white;padding-left:10px;" >SITES</h3> </th>
                                    </tr>
                                    <tr>
                                        <th><a style="cursor:pointer;" onclick="showpage('LojiAirGadek01')" >Loji Air Gadek 1</a> </th>
                                    </tr>
                                    <tr>
                                         <th><a onclick="showpage('LojoAirGadek02')" >Loji Air Gadek 2</a> </th>
                                    </tr>
                                    <tr>
                                        <th><a onclick="showpage('LojoAirGadek03')" >Loji Air Gadek 3</a> </th>
                                    </tr>
                                    <tr>
                                         <th><a onclick="showpage('LojiAirGadek04')" >Loji Air Gadek 4</a> </th>
                                    </tr> 
                                </tbody>
                            </table>
                        </div>
                        <!-- /.box-body-->
                    </div>
                </div>
                 <div class="col-md-10" style="padding-right:0px;padding-left:0px;">
                    <div class="box box-info  box-solid" style="background-color: #ffffff;padding-right:0px;padding-left:0px;">
                        <div class="box-body" style="padding:2px;" >
                              <iframe id="frmshow" style="width: 100%; height: 765px;" src="../custom/LojiAirGadek01.aspx"></iframe>
                        </div>
                        <!-- /.box-body-->
                    </div>
                </div>
            </div>
        </section> 
    </div>
   
</body>
</html>
