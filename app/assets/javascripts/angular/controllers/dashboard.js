/**
 * Created by cschaf on 10/23/14.
 */

'use strict';

app.controller('RestlogDashboardCtrl', ['$http', '$scope', 'MessageService', '$window', '$cookies',
    function($http, $scope, MessageService, $window, $cookies){
        var trendingData;

        // *** Line Char ***
        var ctx = document.getElementById("lineChart").getContext("2d");
        var data = {
    labels: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
    datasets: [
        {
            label: "Misc",
            fillColor: "rgba(102,187,19,0.2)",
            strokeColor: "rgba(102,187,19,1)",
            pointColor: "rgba(102,187,19,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(102,187,19,1)",
            data: [65, 59, 80, 81, 56, 55, 40]
        },
        {
            label: "Info",
            fillColor: "rgba(151,187,205,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: [28, 48, 40, 19, 86, 27, 90]
        },
        {
            label: "Fatal",
            fillColor: "rgba(242,94,95,0.2)",
            strokeColor: "rgba(242,5,29,1)",
            pointColor: "rgba(191,6,24,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(191,6,24,1)",
            data: [4, 34, 7, 25, 65, 31, 78]
        }
    ]
};
        var lineOptions = {
            legendTemplate :
                "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].strokeColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"
        }
        var lineChart = new Chart(ctx).Line(data, lineOptions);

        var legend = lineChart.generateLegend();
        $('#linechartLegend').append(legend);

        // ** Polar Area Chart ***
        var polarCtx = document.getElementById("polarChart").getContext("2d");
        var polardata = [
            {
                value: 124,
                color:"#F7464A",
                highlight: "#FF5A5E",
                label: "Fatal"
            },
            {
                value: 203,
                color: "#46BFBD",
                highlight: "#5AD3D1",
                label: "Info"
            },
            {
                value: 100,
                color: "#FDB45C",
                highlight: "#FFC870",
                label: "Misc"
            },
            {
                value: 40,
                color: "#949FB1",
                highlight: "#A8B3C5",
                label: "Warning"
            },
            {
                value: 120,
                color: "#4D5360",
                highlight: "#616774",
                label: "Debug"
            }

        ];

        var polarChart = new Chart(polarCtx).PolarArea(polardata, {});



        //RECENT MESSAGES
        var lastUpdatedTime = Date.parse($cookies.lastMessageUpdate);
        if(isNaN(lastUpdatedTime)){
            lastUpdatedTime = Math.round(+new Date()/1000);
        }

        MessageService.recentMessages(lastUpdatedTime)
            .then(function(data) {
                //console.log(data.data.report);
                $cookies.lastMessageUpdate = Date.now();
                $scope.recentMessages = data.data.report;
                //var msgs = data.data;
                //console.log("Recent Messages: " + msgs);

        });

        MessageService.dailyMessageCount()
            .then(function(rsp){


                var appData = rsp.data.report;

                var data = { labels: [], datasets: []};
                var dataset = {
                    label: 'Top Apps Today',
                    fillColor: "rgba(220,220,220,0.5)",
                    strokeColor: "rgba(220,220,220,0.8)",
                    highlightFill: "rgba(220,220,220,0.75)",
                    highlightStroke: "rgba(220,220,220,1)",
                    data: []
                };
                _.each(appData, function(app){
                   // console.log('app: ' + app.app);
                    data.labels.push(app.app);
                    dataset.data.push(app.count);
                });

                data.datasets.push(dataset);
              //  console.log(data);
                if(document.getElementById('dlyAppCnt')) {
                     try{
                         var chartCanvas = document.getElementById('dlyAppCnt').getContext("2d");
                         var dailyBarChart = new Chart(chartCanvas).Bar(data, {});
                     }   catch(err){
                         console.log(err);
                         console.log("js hasent had time to load yet");
                     }
                }


            }, function(error){
                console.log('error: ', error);
            });


}]);
