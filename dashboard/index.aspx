<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
          <h1>
            Dashboard
            <small>Control panel</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Dashboard</li>
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
                  <h3><%=Regcnt %></h3>
                  <p>Total Subscribers</p>
                </div>
                <div class="icon">
                  <i class="ion ion-person-add"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-green">
                <div class="inner">
                  <h3><%=ActiveCnt %> </h3>
                  <p>Active Subscribers</p>
                </div>
                <div class="icon">
                  <i class="ion ion-person-add"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-yellow">
                <div class="inner">
                  <h3><%=DeActivecnt %></h3>
                  <p>DeActive Subscribers</p>
                </div>
                <div class="icon">
                  <i class="ion ion-person-add"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-red">
                <div class="inner">
                  <h3><%=BlacklistCnt %></h3>
                  <p>Blacklist Subscribers</p>
                </div>
                <div class="icon">
                  <i class="ion ion-person-add"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
              </div>
            </div><!-- ./col -->
          </div><!-- /.row -->
          <!-- Main row -->
          <div class="row">
            <!-- Left col -->
            <section class="col-lg-7 connectedSortable">
              <!-- Custom tabs (Charts with tabs)-->
                 <div class="box  box-info box-solid" style ="background-color:#ffffff;">
                <div class="box-header">
                  <i class="fa  fa-bar-chart" style="color:White;"></i>
                  <h3 class="box-title" style ="color:White;">Packages</h3> 
                </div>
                <div class="box-body chat" id="Div1">
                  <div class="chart tab-pane active" id="package-chart" style="position: relative; height: 400px;"></div>
                </div> 
              </div><!-- /.box (chat box) -->

              <!-- Chat box -->
              <div class="box box-info">
                <div class="box-header">
                  <i class="fa fa-map-marker"></i>
                  <h3 class="box-title">Visitors</h3> 
                </div>
                <div class="box-body chat" id="chat-box">
                 <div id="map" style="height:285px;"></div> 
                </div><!-- /.chat -->
                <div class="box-footer">
                   
                </div>
              </div><!-- /.box (chat box) -->

               
            </section><!-- /.Left col -->
            <!-- right col (We are only adding the ID to make the widgets sortable)-->
            <section class="col-lg-5 connectedSortable">

              <!-- Map box -->
              <div class="box box-info  box-solid" style ="background-color:#ffffff;">
                <div class="box-header"> 
                  <i class="fa  fa-pie-chart"></i>
                  <h3 class="box-title">
                    Packages
                  </h3>
                </div>
                <div class="box-body">
                  <div id="piechart" style="width:100%; height: 390px;"></div> 
                </div><!-- /.box-body-->
                
              </div>
              <!-- /.box -->

              <!-- solid sales graph -->
              <div class="box box-solid" style ="background-color:#990099;height:350px;">
                <div class="box-header" style ="color:White;">
                  <i class="fa fa-th"></i>
                  <h3 class="box-title">List Of LCO</h3> 
                </div>
                <div class="box-body border-radius-none"  >
                  <marquee direction="up">
                  <div class ="row">
                  <div class ="col-md-12" style ="padding-left:120px; color:White;"> 
                    <address >
                    <strong>SUBHODAYA DIGITAL</strong><br>
                    795 Folsom Ave, Suite 600<br>
                    San Francisco, CA 94107<br>
                    Phone: (555) 539-1037<br>
                    Email: john.doe@example.com
                   </address>

                    <address>
                    <strong>HDS DIGITAL</strong><br>
                    795 Folsom Ave, Suite 600<br>
                    San Francisco, CA 94107<br>
                    Phone: (555) 539-1037<br>
                    Email: john.doe@example.com
                   </address>  
                  </div>
                  </div> 
                  </marquee>
                </div> 
              </div><!-- /.box -->

    
            </section><!-- right col -->
          </div><!-- /.row (main row) -->

        </section>
    <!-- /.content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="Server">
    <script type="text/javascript">
    $(function () { 
        initMap();
        getdata();
    });

    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom:8,
            center:new google.maps.LatLng(17.462707,78.544651)
        });

        var lats=[17.462707,17.462707,17.462707,17.462707 ];
        var lng=[78.462707,78.782707,78.552707,78.762707 ];
        var myLatLng;
        var markars=[];
        for(var i=0;i<lats.length;i++){
             myLatLng =new google.maps.LatLng(lats[i],lng[i]);
               markars[i] = new google.maps.Marker({
                position: myLatLng,
                map: map,
                title: 'Hello World!'
              });
          }
    } 

    function LoadPieChart(response)
    {
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
       var seriesdata=[];
        var adata=['Package', 'Subscribers'];
        seriesdata.push(adata)
           for (var i = 0; i < response[0].length; i++) {
                    adata =[response[0][i], response[1][i]];
                    seriesdata.push(adata);
                }
        var data = google.visualization.arrayToDataTable(seriesdata);
        
        var options = {
          title: 'Subscribers', 
          backgroundColor:"#ffffff",
          titleTextStyle:
          {
           fontSize: 16
          }
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
    }
    function getdata() {

        $.ajax({
            type: "POST",
            url: "index.aspx/GetPackageSummary",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var seriesdata = response.d[1];
                var packages = response.d[0];
                $('#package-chart').highcharts({
                    chart: {
                        type: 'column',
                        backgroundColor: '#ffffff',
                        style: { 
                                color: "#000000"
                            }
                    },
                    title: {
                        text: "Packages Info",
                         style: {
                             color: '#000000',
                          }
                    },
                    xAxis: {
                        categories: packages,
                        labels: {
                            rotation: -45,
                            style: {
                                color: '#000000',
                                fontSize: '13px',
                                fontFamily: 'Verdana, sans-serif'
                            }
                        }
                    },
                    yAxis: {
                        min: 0,
                        labels: {
                          style: {
                             color: '#000000'
                          }
                          },
                        title: {
                            text: "Num Of Subscribers",
                            style: {
                             color: '#000000'
                             }
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    tooltip: {
                        pointFormat: "No of Subscribers: <b>{point.y:.0f} </b>"
                    },
                    series: [{
                        name: 'Packages',
                        color: '#F20075',
                        data: seriesdata,
                         dataLabels: {
                            enabled: true,
                            rotation: -90,
                            color: '#ffffff',
                            align: 'right',
                            format: '{point.y:.0f}', // one decimal
                            y: 10, // 10 pixels down from the top
                            style: { 
                                fontSize: '13px',
                                fontFamily: 'Verdana, sans-serif'
                            }
                        }
                    }]
                });

                LoadPieChart(response.d);
            },
            failure: function (response) {
                alertbox("Failed");
            }
        }); 
       
    }
            
            
    </script>
</asp:Content>
