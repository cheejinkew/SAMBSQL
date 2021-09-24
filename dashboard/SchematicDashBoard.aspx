<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SchematicDashBoard.aspx.cs" Inherits="dashboard_SchematicDashBoard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>SAMB| Schematic Dashboard</title>
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
        a { 
            padding-left:0px;
        color: white; 
       cursor:pointer;
       text-align:right;
        }
    </style>
    <script type ="text/javascript">
        setdefault();
        function setdefault()
        {
            document.getElementById('frmshow').src = "../custom/bph_48a.aspx";
        }
        
        function showpage(page)
        { 
            document.getElementById('frmshow').src = "../custom/" + page + ".aspx";
        }
    </script>
</head>
<body>
    <div class="content-wrapper" style="margin-left: 0px;">
         <section class="content-header">
            <h1>Schematic Dashboard  
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i>Schematic Dashboard</a></li>
            </ol>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-md-2" style ="padding-right:0px;padding-left:0px;" >
                    <div class="box box-info  box-solid" style="background-color: #ffffff;height: 765px;">
                        <div class="box-body" style="padding:2px;height: 765px;">
                            <table class="table table-condensed"  >
                                <tbody>
                                     <tr>
                                        <th><h3 style="color:white;padding-left:10px;" >SITES</h3> </th>
                                    </tr>
                                        <tr>
                                        <th><a  onclick="showpage('bph_sq1')" >LOJI AIR SEBUKOR KE LORONG PANDAN</a> </th>
                                    </tr>
                                        <tr>
                                        <th><a  onclick="showpage('bph_47b')" >LOJI AIR SEBUKOR KE HOSPITAL MELAKA</a> </th>
                                    </tr>
                                    <tr>
                                        <th><a  onclick="showpage('bph_48a')" >CWT WEIR - BUKIT BERUANG - TANGKI TYT</a> </th>
                                    </tr>
                                    <tr>
                                         <th><a onclick="showpage('bph_48b')" >CWT WEIR - BUKIT DUYONG - PULAU BESAR</a> </th>
                                    </tr>
                                    <tr>
                                        <th><a onclick="showpage('bph_48c')" >CWT WEIR - CHENG BARU/LAMA -ASU LAMA</a> </th>
                                    </tr>
                                    <tr>
                                         <th><a onclick="showpage('bph_48d')" >CWT PCM-BUKIT LESONG-MITC</a> </th>
                                    </tr>
                                    <tr>
                                        <th><a onclick="showpage('bph_48e')" >CWT KUBOTA & WEIR - SEN B1 & B2 KE DURIAN TUNGGAL</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_48f')" >CWT KUBOTA & WEIR - SEN B1 & B2 KE BUKIT BULAT DAN SUNPOWER </a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bphLAB_43_7')" >CWT KUBOTA & WEIR - SEN B1 & B2 KE BUKIT BULAT DAN HUTAN PERCHA</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_49a')" >CWT DAF1 - SENANDONG A - PULAU BESAR</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_49b')" >CWT DAF1 - BERANGAN - PULAU MELAKA</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAB_43_3')" >CWT DAF1 - BERANGAN - MUZAFFAR</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAB_43_4')" >CWT DAF1 - BERANGAN - BUKIT BERUANG</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAD1_43_5')" >CWT DAF1 - BERANGAN - AIR KEROH GOLF - VISTA KIRANA</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAD1_43_6')" >CWT DAF1 - SENANDONG B3 - SELANDAR - KOLAM JUS</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAD1_43_7')" >CWT DAF1 - SENANDONG B3 - SELANDAR LAMA - KG ORANG ASLI GAPAM</a> </th>
                                    </tr>
                                    <tr>
                                        <th><a onclick="showpage('bph_LAD1_43_8')" >CWT DAF1 - SENANDONG B3 - KG BKT SEDANAN</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAD1_43_9')" >CWT DAF1 - SENANDONG B3 - BEMBAN 1 - TMN BEMBAN UTAMA</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAD1_43_10')" >CWT DAF1 - SENANDONG B3 - BEMBAN 2 - TMN SERKAM RIA</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAD1_43_11')" >CWT DAF1 - SENANDONG B3 - BKT SEKAWANG - R/AWAM TG DAHAN</a> </th>
                                    </tr>
                                      <tr>
                                        <th><a onclick="showpage('bph_LAD1_43_12')" >CWT DAF1 - SENANDONG B3 - KESANG PAJAK - JARIM JAYA</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAD2_43_1')" >(LOJI AIR DAF 2 KE KOLAM AIR SALAK DAF2 KE TANGKI TMN PERUNA)</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAD2_43_2')" >(LOJI AIR DAF 2 KE KOLAM AIR SALAK DAF2 KE TANGKI TMN HANG TUAH)</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAD2_43_3')" >(LOJI AIR DAF 2 KE KOLAM JELUTONG KE KOLAM INDUSTRI REMBIA)</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAD2_43_4')" >(LOJI AIR DAF 2 KE KOLAM BKT KUDA KE AIR SALAK BARU)</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAG_43_1')" >CWT GADEK - PULAU SEBANG</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAG_43_2')" >CWT GADEK - LENDU - BKT SERAYA - BANDAR BARU</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAG_43_3')" >CWT GADEK - LENDU - INDUSTRI PENGKALAN BALAK</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAG_43_4')" >CWT GADEK - LENDU - RAMUAN CINA BESAR(ABJV)</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAG_43_5')" >CWT GADEK - LENDU -BUKIT SERAYA 1</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAG_43_6')" >CWT GADEK - BUKIT TIGA - INDUSTRI REMBIA</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAG_43_7')" >CWT GADEK - BUKIT TIGA - BUKIT PAYUNG</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAG_43_8')" >CWT GADEK - BUKIT TIGA - SG.BULOH - FELCRA RAMUAN CINA</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAG_43_9')" >CWT GADEK - BKT PANDAN - BUKIT SERAYA 2</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAA_43_1')" >CWT ASAHAN - GAPIS - FELDA BKT SENGGEH 1</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAA_43_2')" >CWT ASAHAN - BKT BENDERA - FELDA BKT SENGGEH 2</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAA_43_3')" >CWT ASAHAN - SPG BEKOH - SOLOK MERIANG</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAC_43_1')" >CWT CHINCHIN - SPG BEKOH - KG GUBAH </a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAM_43_1')" >CWT MERLIMAU - BKT BAHUDDIN 2 - KG GUBAH </a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAM_43_2')" >CWT MERLIMAU - ABJV- TAMAN PAHLAWAN</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAM_43_3')" >CWT MERLIMAU - BKT PERAH BARU - SUNGAI RAMBAI</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAJ_43_1')" >CWT JUS -KOLAM JUS - JUS PERMAI</a> </th>
                                    </tr>
                                     <tr>
                                        <th><a onclick="showpage('bph_LAJ_43_2')" >CWT JUS - BTG MELAKA - TAMAN CAHAYA, TEBONG</a> </th>
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
                              <iframe id="frmshow" style="width: 100%; height: 765px;" src="../custom/bph_48a.aspx"></iframe>
                        </div>
                        <!-- /.box-body-->
                    </div>
                </div>
            </div>
        </section> 
    </div>
   
</body>
</html>
