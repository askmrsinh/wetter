<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<jsp:include page="resources/includes/api.jsp" />

<html>

<jsp:include page="resources/includes/head.jsp" />
<body onload="getLocation()">
	<jsp:include page="resources/includes/nav.jsp" />
	<div class="container-fluid stat">
		<div id="container1" style="min-width: 310px; height: 400px; margin: auto"></div>
		<div id="container2" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
		<div id="container3" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
		<div id="container4" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
	</div>
	
	<jsp:include page="resources/includes/footer.jsp" />
	<script src="https://code.highcharts.com/stock/highstock.js"></script>
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/highcharts-more.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script>
		$(function () {
		    $('#container1').highcharts({
		        chart: {
		            zoomType: 'xy'
		        },
		        title: {
		            text: 'Average Monthly Weather Data for Tokyo'
		        },
		        subtitle: {
		            text: 'Source: WorldClimate.com'
		        },
		        xAxis: [{
		            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
		                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		            crosshair: true
		        }],
		        yAxis: [{ // Primary yAxis
		            labels: {
		                format: '{value}°C',
		                style: {
		                    color: Highcharts.getOptions().colors[2]
		                }
		            },
		            title: {
		                text: 'Temperature',
		                style: {
		                    color: Highcharts.getOptions().colors[2]
		                }
		            },
		            opposite: true
	
		        }, { // Secondary yAxis
		            gridLineWidth: 0,
		            title: {
		                text: 'Rainfall',
		                style: {
		                    color: Highcharts.getOptions().colors[0]
		                }
		            },
		            labels: {
		                format: '{value} mm',
		                style: {
		                    color: Highcharts.getOptions().colors[0]
		                }
		            }
	
		        }, { // Tertiary yAxis
		            gridLineWidth: 0,
		            title: {
		                text: 'Sea-Level Pressure',
		                style: {
		                    color: Highcharts.getOptions().colors[1]
		                }
		            },
		            labels: {
		                format: '{value} mb',
		                style: {
		                    color: Highcharts.getOptions().colors[1]
		                }
		            },
		            opposite: true
		        }],
		        tooltip: {
		            shared: true
		        },
		        legend: {
		            layout: 'vertical',
		            align: 'left',
		            x: 80,
		            verticalAlign: 'top',
		            y: 55,
		            floating: true,
		            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
		        },
		        series: [{
		            name: 'Rainfall',
		            type: 'column',
		            yAxis: 1,
		            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
		            tooltip: {
		                valueSuffix: ' mm'
		            }
	
		        }, {
		            name: 'Sea-Level Pressure',
		            type: 'spline',
		            yAxis: 2,
		            data: [1016, 1016, 1015.9, 1015.5, 1012.3, 1009.5, 1009.6, 1010.2, 1013.1, 1016.9, 1018.2, 1016.7],
		            marker: {
		                enabled: false
		            },
		            dashStyle: 'shortdot',
		            tooltip: {
		                valueSuffix: ' mb'
		            }
	
		        }, {
		            name: 'Temperature',
		            type: 'spline',
		            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6],
		            tooltip: {
		                valueSuffix: ' °C'
		            }
		        }]
		    });
		});
		// Data retrieved from http://vikjavev.no/ver/index.php?spenn=2d&sluttid=16.06.2015.
		$(function () {
		    $('#container2').highcharts({
		        chart: {
		            type: 'spline'
		        },
		        title: {
		            text: 'Wind speed during two days'
		        },
		        subtitle: {
		            text: 'May 31 and and June 1, 2015 at two locations in Vik i Sogn, Norway'
		        },
		        xAxis: {
		            type: 'datetime',
		            labels: {
		                overflow: 'justify'
		            }
		        },
		        yAxis: {
		            title: {
		                text: 'Wind speed (m/s)'
		            },
		            minorGridLineWidth: 0,
		            gridLineWidth: 0,
		            alternateGridColor: null,
		            plotBands: [{ // Light air
		                from: 0.3,
		                to: 1.5,
		                color: 'rgba(68, 170, 213, 0.1)',
		                label: {
		                    text: 'Light air',
		                    style: {
		                        color: '#606060'
		                    }
		                }
		            }, { // Light breeze
		                from: 1.5,
		                to: 3.3,
		                color: 'rgba(0, 0, 0, 0)',
		                label: {
		                    text: 'Light breeze',
		                    style: {
		                        color: '#606060'
		                    }
		                }
		            }, { // Gentle breeze
		                from: 3.3,
		                to: 5.5,
		                color: 'rgba(68, 170, 213, 0.1)',
		                label: {
		                    text: 'Gentle breeze',
		                    style: {
		                        color: '#606060'
		                    }
		                }
		            }, { // Moderate breeze
		                from: 5.5,
		                to: 8,
		                color: 'rgba(0, 0, 0, 0)',
		                label: {
		                    text: 'Moderate breeze',
		                    style: {
		                        color: '#606060'
		                    }
		                }
		            }, { // Fresh breeze
		                from: 8,
		                to: 11,
		                color: 'rgba(68, 170, 213, 0.1)',
		                label: {
		                    text: 'Fresh breeze',
		                    style: {
		                        color: '#606060'
		                    }
		                }
		            }, { // Strong breeze
		                from: 11,
		                to: 14,
		                color: 'rgba(0, 0, 0, 0)',
		                label: {
		                    text: 'Strong breeze',
		                    style: {
		                        color: '#606060'
		                    }
		                }
		            }, { // High wind
		                from: 14,
		                to: 15,
		                color: 'rgba(68, 170, 213, 0.1)',
		                label: {
		                    text: 'High wind',
		                    style: {
		                        color: '#606060'
		                    }
		                }
		            }]
		        },
		        tooltip: {
		            valueSuffix: ' m/s'
		        },
		        plotOptions: {
		            spline: {
		                lineWidth: 4,
		                states: {
		                    hover: {
		                        lineWidth: 5
		                    }
		                },
		                marker: {
		                    enabled: false
		                },
		                pointInterval: 3600000, // one hour
		                pointStart: Date.UTC(2015, 4, 31, 0, 0, 0)
		            }
		        },
		        series: [{
		            name: 'Hestavollane',
		            data: [0.2, 0.8, 0.8, 0.8, 1, 1.3, 1.5, 2.9, 1.9, 2.6, 1.6, 3, 4, 3.6, 4.5, 4.2, 4.5, 4.5, 4, 3.1, 2.7, 4, 2.7, 2.3, 2.3, 4.1, 7.7, 7.1, 5.6, 6.1, 5.8, 8.6, 7.2, 9, 10.9, 11.5, 11.6, 11.1, 12, 12.3, 10.7, 9.4, 9.8, 9.6, 9.8, 9.5, 8.5, 7.4, 7.6]

		        }, {
		            name: 'Vik',
		            data: [0, 0, 0.6, 0.9, 0.8, 0.2, 0, 0, 0, 0.1, 0.6, 0.7, 0.8, 0.6, 0.2, 0, 0.1, 0.3, 0.3, 0, 0.1, 0, 0, 0, 0.2, 0.1, 0, 0.3, 0, 0.1, 0.2, 0.1, 0.3, 0.3, 0, 3.1, 3.1, 2.5, 1.5, 1.9, 2.1, 1, 2.3, 1.9, 1.2, 0.7, 1.3, 0.4, 0.3]
		        }],
		        navigation: {
		            menuItemStyle: {
		                fontSize: '10px'
		            }
		        }
		    });
		});
		$(function () {
		    $('#container3').highcharts({
		        chart: {
		            type: 'column'
		        },
		        title: {
		            text: 'Monthly Average Rainfall'
		        },
		        subtitle: {
		            text: 'Source: WorldClimate.com'
		        },
		        xAxis: {
		            categories: [
		                'Jan',
		                'Feb',
		                'Mar',
		                'Apr',
		                'May',
		                'Jun',
		                'Jul',
		                'Aug',
		                'Sep',
		                'Oct',
		                'Nov',
		                'Dec'
		            ],
		            crosshair: true
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: 'Rainfall (mm)'
		            }
		        },
		        tooltip: {
		            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		                '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
		            footerFormat: '</table>',
		            shared: true,
		            useHTML: true
		        },
		        plotOptions: {
		            column: {
		                pointPadding: 0.2,
		                borderWidth: 0
		            }
		        },
		        series: [{
		            name: 'Tokyo',
		            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]

		        }, {
		            name: 'New York',
		            data: [83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3]

		        }, {
		            name: 'London',
		            data: [48.9, 38.8, 39.3, 41.4, 47.0, 48.3, 59.0, 59.6, 52.4, 65.2, 59.3, 51.2]

		        }, {
		            name: 'Berlin',
		            data: [42.4, 33.2, 34.5, 39.7, 52.6, 75.5, 57.4, 60.4, 47.6, 39.1, 46.8, 51.1]

		        }]
		    });
		});
		$(function () {

		    $('#container4').highcharts({

		        chart: {
		            type: 'columnrange',
		            inverted: true
		        },

		        title: {
		            text: 'Temperature variation by month'
		        },

		        subtitle: {
		            text: 'Observed in Vik i Sogn, Norway'
		        },

		        xAxis: {
		            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
		        },

		        yAxis: {
		            title: {
		                text: 'Temperature ( °C )'
		            }
		        },

		        tooltip: {
		            valueSuffix: '°C'
		        },

		        plotOptions: {
		            columnrange: {
		                dataLabels: {
		                    enabled: true,
		                    formatter: function () {
		                        return this.y + '°C';
		                    }
		                }
		            }
		        },

		        legend: {
		            enabled: false
		        },

		        series: [{
		            name: 'Temperatures',
		            data: [
		                [-9.7, 9.4],
		                [-8.7, 6.5],
		                [-3.5, 9.4],
		                [-1.4, 19.9],
		                [0.0, 22.6],
		                [2.9, 29.5],
		                [9.2, 30.7],
		                [7.3, 26.5],
		                [4.4, 18.0],
		                [-3.1, 11.4],
		                [-5.2, 10.4],
		                [-13.5, 9.8]
		            ]
		        }]

		    });

		});
	</script>
</body>

</html>