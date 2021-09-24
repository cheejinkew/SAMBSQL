<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dashboard.aspx.cs" Inherits="dashboard_dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>SAMB| Dashboard</title>
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
    <style type ="text/css">
        .icon {
            top:-25px  !important;
            right:30px !important;
        }
    </style>
</head>
<body>
    <div class="content-wrapper" style="margin-left:0px;">
        <section class="content-header">
            <h1>Dashboard  
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i>Dashboard</a></li>
            </ol>
        </section>
        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-lg-3 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-aqua">
                        <div class="inner">
                            <h3 id="lbltotal">200</h3>
                            <p>Total Sites</p>
                        </div>
                        <div class="icon">
                           <img src="RES.png" />
                        </div>
                        <a href="#" onclick="showdata('Updated')" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-3 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-green">
                        <div class="inner">
                            <h3 id="lblactive">200 </h3>
                            <p>Active Sites</p>
                        </div>
                        <div class="icon">
                           <img src="RES.png" />
                        </div>
                        <a href="#" onclick="showdata('Updated')" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-3 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-yellow">
                        <div class="inner">
                            <h3 id="lbldelay">0</h3>
                            <p>Delay Sites</p>
                        </div>
                        <div class="icon">
                           <img src="RES.png" />
                        </div>
                        <a href="#" onclick="showdata('Delay')" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-3 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-red">
                        <div class="inner">
                            <h3 id="lblstopped">0</h3>
                            <p>Data Stopped</p>
                        </div>
                        <div class="icon">
                            <img src="RES.png" />
                        </div>
                        <a href="#" onclick="showdata('Stopped')" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
                <!-- ./col -->
            </div>
            <!-- /.row -->
            <!-- Main row -->
            <div class="row">
                <!-- Left col -->
                <section class="col-lg-6 connectedSortable">
                    <!-- Custom tabs (Charts with tabs)-->
                    <div class="box  box-info box-solid" style="background-color: #ffffff;">
                        <div class="box-header">
                            <i class="fa  fa-pie-chart" style="color: White;"></i>
                            <h3 class="box-title" style="color: White;">Status Of Sites</h3>
                        </div>
                        <div class="box-body chat" id="Div1">
                            <div class="chart tab-pane active" id="package-chart" style="position: relative; height: 400px;"></div>
                        </div>
                    </div>
                </section>
                <!-- /.Left col -->
                <!-- right col (We are only adding the ID to make the widgets sortable)-->
                <section class="col-lg-6 connectedSortable">
                    <!-- Map box -->
                    <div class="box box-info  box-solid" style="background-color: #ffffff;">
                        <div class="box-header">
                            <i class="fa fa-bell"></i>
                            <h3 class="box-title">Events</h3>
                        </div>
                        <div class="box-body">
                            <iframe id="events" style="width: 100%; height: 390px;" src ="../alert1.aspx"></iframe>
                        </div>
                        <!-- /.box-body-->
                    </div>
                </section>
                <!-- right col -->
            </div>
            <!-- /.row (main row) -->
        </section>
        <!-- /.content -->
    </div>
      
</body>
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- ChartJS 1.0.1 -->
<script src="plugins/chartjs/Chart.min.js" type="text/javascript"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.min.js" type="text/javascript"></script>
<script src="dist/js/moment.min.js" type="text/javascript"></script>
<script src="plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
<script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="plugins/timepicker/bootstrap-timepicker.min.js" type="text/javascript"></script>
<!-- bootstrap color picker -->
<script src="plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
<script src="plugins/knob/jquery.knob.js" type="text/javascript"></script>
<script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
<script src="plugins/bootstrap-slider/bootstrap-slider.js" type="text/javascript"></script>
<!-- Ion Slider -->
<script src="plugins/ionslider/ion.rangeSlider.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<script src="dist/js/jquery.horizBarChart.min.js"></script>
<script src="dist/js/apps.js"></script>
<script src="dist/js/blankon.dashboard.retail.js"></script>
<script src="plugins/iCheck/icheck.min.js"></script>
<script src="dist/js/highcharts.js"></script>
<script type="text/javascript">
    $(function () {
        getdata();
        setTimeout('getdata()', 30000);
    });
    function showdata(status)
    {
        var sDist = 'ALL';
        $.ajax({
                type: "POST",
                url: "dashboard.aspx/GetSatusSummaryDataJson",
                data: '{sDist: \"' + sDist + '\" , status: \"' + status + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var table = $("#tblRenewpkgs");
                    $("#cttbody").empty(); 
                    var sno=1;
                    for (var i = 0; i < response.d.length; i++) {
                        $("#cttbody").append("<tr><td>" + sno + "</td><td>" + response.d[i].District + "</td><td>" + response.d[i].Type + "</td><td>" + response.d[i].SiteName + "</td><td>" + response.d[i].TimeStamp + "</td><td>" + response.d[i].Level + "</td></tr>");
                       sno=sno+1;
                    }
                    $("#OperationModal").modal('show');
                },
                failure: function (response) {
                alertbox("Failed");
               }
         }); 
    }
    function getdata() {
        var sDist = 'ALL';
        $.ajax({
            type: "POST",
            url: "dashboard.aspx/GetDashBoardJson",
            data: '{sDist: \"' + sDist + '\"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var seriesdata = response.d.sd;
                var updatestatud = response.d.dd;
                $("#lbltotal").html(updatestatud.total);
                $("#lbldelay").html(updatestatud.delay);
                $("#lblactive").html(updatestatud.updated);
                $("#lblstopped").html(updatestatud.stopped);
                Highcharts.chart('package-chart', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: 'Reservoirs Level Status'
                    },
                    tooltip: {
                        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: false
                            },
                            showInLegend: true
                        }
                    },
                    series: [{
                        name: 'Status',
                        colorByPoint: true,
                        data: [{
                            name: 'HH' + " ( " + seriesdata.HH + " )",
                            y: seriesdata.HH,
                            sliced: true,
                            selected: true,
                            color: '#FF0000'
                        }, {
                            name: 'H' + " ( " + seriesdata.H + " )",
                            y: seriesdata.H,
                            color: '#F75905'
                        }, {
                            name: 'NN' + " ( " + seriesdata.NN + " )",
                            y: seriesdata.NN,
                            color: '#1170F4'
                        }, {
                            name: 'L' + " ( " + seriesdata.L + " )",
                            y: seriesdata.L,
                            color: '#FFC300'
                        }, {
                            name: 'LL' + " ( " + seriesdata.LL + " )",
                            y: seriesdata.LL,
                            color: '#CC700F'
                        }
                        ]
                    }]
                });
            },
            failure: function (response) {
                alertbox("Failed");
            }
        });

    }

</script>
</html>
