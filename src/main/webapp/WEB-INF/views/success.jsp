<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@page import="java.util.Map.Entry"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>success page</title>

<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="<c:url value="/resources/js/bootstrap.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>

<script>
	function formSubmit() {
		document.getElementById("logoutForm").submit();
	}
</script>


<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>


<!-- code to get critical graph -->
<script type="text/javascript">
	// occurance Graph data
<%HashMap<String, Integer> f_map = new HashMap<String, Integer>();
			f_map = ((HashMap<String, Integer>) session.getAttribute("fc_map"));
			System.out.println("fc_map size from req:" + f_map.size());
			request.setAttribute("f_map", f_map);
			ArrayList<String> UI_ck = new ArrayList<String>();
			ArrayList<Integer> UI_vl = new ArrayList<Integer>();

			Iterator<Map.Entry<String, Integer>> iter = f_map.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry<String, Integer> entry = iter.next();
				if (entry.getValue() == 0) {
					iter.remove();
				}
			}
			for (Entry<String, Integer> entry : f_map.entrySet()) {
				String hkey = entry.getKey();
				Integer value = entry.getValue();
				//System.out.println("hostanmes from e_map:" + hkey + " = " + "value: " + value);
				UI_ck.add(hkey);
				UI_vl.add(value);
			}
			request.setAttribute("UI_ck", UI_ck);
			request.setAttribute("UI_vl", UI_vl);%>
		google.charts.load('current', {
			'packages' : [ 'corechart' ]
		});
		google.charts.setOnLoadCallback(drawStuff);

		function drawStuff() {

		// Create and populate the data table.
			var jshostArray = [];
			<%for (int i = 0; i < UI_ck.size(); i++) {%>
			jshostArray.push("<%=UI_ck.get(i)%>");
			<%}%>
			
			var jsvalueArray = [];
			<%for (int i = 0; i < UI_vl.size(); i++) {%>
			jsvalueArray.push("<%=UI_vl.get(i)%>");
			<%}%>
		// Create and populate the data table.
			var hostnames = jshostArray.slice();
			var count = jsvalueArray.slice();

			var data = new google.visualization.DataTable();
			data.addColumn('string', 'Hostnames');
			data.addColumn('number', 'ReaptedTimes');
		
			for (i = 0; i < hostnames.length; i++) {
				data.addRow([ hostnames[i], parseInt(count[i]) ]);
			}

			var options = {
					title : 'Total# instances all Critical Hosts',
					width : 600,
					height: 350,
					is3D: true,
					backgroundColor : "#E6E6FA",
					tooltip: { isHtml: true } 
			};

			var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
			// Convert the Classic options to Material options.
			chart.draw(data, options);
		}; 
</script>

<!-- code to get error graph -->
<script type="text/javascript">
	// occurance Graph data
<%HashMap<String, Integer> f_emap = new HashMap<String, Integer>();
			f_emap = ((HashMap<String, Integer>) session.getAttribute("fe_map"));
			System.out.println("f_emap size from req:" + f_emap.size());
			request.setAttribute("f_emap", f_emap);
			ArrayList<String> UI_ek = new ArrayList<String>();
			ArrayList<Integer> UI_evl = new ArrayList<Integer>();

			Iterator<Map.Entry<String, Integer>> eiter = f_emap.entrySet().iterator();
			while (eiter.hasNext()) {
				Map.Entry<String, Integer> entry = eiter.next();
				if (entry.getValue() == 0) {
					eiter.remove();
				}
			}

			for (Entry<String, Integer> entry : f_emap.entrySet()) {
				String hekey = entry.getKey();
				Integer evalue = entry.getValue();
				//	System.out.println("hostanmes from e_map:" + hekey + " = " + "value: " + evalue);
				UI_ek.add(hekey);
				UI_evl.add(evalue);
			}

			//request.setAttribute("UI_ek", UI_ek);
			//request.setAttribute("UI_evl", UI_evl);%>
		google.charts.load('current', {
			'packages' : [ 'corechart' ]
		});
		google.charts.setOnLoadCallback(drawStuff);

		function drawStuff() {

		// Create and populate the data table.
			var jshostArray = [];
			<%for (int i = 0; i < UI_ek.size(); i++) {%>
			jshostArray.push("<%=UI_ek.get(i)%>");
			<%}%>
			
			var jsvalueArray = [];
			<%for (int i = 0; i < UI_evl.size(); i++) {%>
			jsvalueArray.push("<%=UI_evl.get(i)%>");
			<%}%>
		// Create and populate the data table.
			var hostnames = jshostArray.slice();
			var count = jsvalueArray.slice();

			var data = new google.visualization.DataTable();
			data.addColumn('string', 'Hostnames');
			data.addColumn('number', 'ReaptedTimes');
		
			for (i = 0; i < hostnames.length; i++) {
				data.addRow([ hostnames[i], parseInt(count[i]) ]);
			}

			var options = {
					title : 'Total# instances all Error Hosts',
					width : 600,
					height: 350,
					is3D: true,
					backgroundColor : "#E6E6FA",
					tooltip: { isHtml: true } 
			};

			var chart = new google.visualization.PieChart(document.getElementById('egchart_div'));
			// Convert the Classic options to Material options.
			chart.draw(data, options);
		}; 
</script>

<!-- code to get top five critical  graph  wrt UK total key-->
<script type="text/javascript">
<%class ValueComparator implements Comparator<String> {
				Map<String, Integer> base;
				public ValueComparator(Map<String, Integer> base) {
					this.base = base;
				}
				public int compare(String a, String b) {
					if (base.get(a) >= base.get(b)) {
						return -1;
					} else {
						return 1;
					}
				}
			}
			HashMap<String, Integer> tc_map = new HashMap<String, Integer>();
			tc_map = ((HashMap<String, Integer>) session.getAttribute("ukc_map"));
			request.setAttribute("tc_map", tc_map);
			System.out.println("tc_map map size form req: " + tc_map);

			ArrayList<String> UI_tck = new ArrayList<String>();
			ArrayList<Integer> UI_tcvl = new ArrayList<Integer>();

			ValueComparator bvc = new ValueComparator(tc_map);
			TreeMap<String, Integer> tc_sorted_map = new TreeMap<String, Integer>(bvc);

			//System.out.println("unsorted map: " + tc_map);
			tc_sorted_map.putAll(tc_map);
			//System.out.println("results sorted  " + tc_sorted_map);
			//session.setAttribute("sorted_map", sorted_map);

			List keys = new ArrayList(tc_sorted_map.keySet());
			for (int i = 0; i < keys.size(); i++) {
				String tckey = keys.get(i).toString();
				Integer tcvalue = tc_map.get(tckey);
				if (i <= 4) {
					UI_tck.add(tckey);
					UI_tcvl.add(tcvalue);
				}
			}

			request.setAttribute("UI_tck", UI_tck);
			session.setAttribute("UI_tck", UI_tck);
			request.setAttribute("UI_tcvl", UI_tcvl);%>
			
google.charts.load('current', {	'packages' : [ 'corechart' ] });
google.charts.setOnLoadCallback(tc_drawStuff);

function tc_drawStuff() {

	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Uniquekeys');
	data.addColumn('number', 'ReaptedTimes');
	
	// Create and populate the data table.
	var jshostArray = [];
	<%for (int j = 0; j < UI_tck.size(); j++) {%>
	jshostArray.push("<%=UI_tck.get(j)%>");
	<%}%>
	
	var jsvalueArray = [];
	<%for (int k = 0; k < UI_tcvl.size(); k++) {%>
	jsvalueArray.push("<%=UI_tcvl.get(k)%>");
	<%}%>

	// Create and populate the data table.
	var hostnames = jshostArray.slice();
	var count = jsvalueArray.slice();
	
	for (i = 0; i < hostnames.length; i++) {
		data.addRow([ hostnames[i], parseInt(count[i]) ]);
	}
		

		var options = {
			title : 'Total# instances top 5 Critical',
			width : 600,
			height: 350,
			is3D: true,
			backgroundColor : "#E6E6FA",
			tooltip: { isHtml: true } 
		};

		// Instantiate and draw the chart for top 5 critical .
        var chart = new google.visualization.PieChart(document.getElementById('tc_chart_div'));
        chart.draw(data, options);
	};
</script>

<!-- code to get top five error  graph  wrt UK total key--->
<script type="text/javascript">
<%HashMap<String, Integer> te_map = new HashMap<String, Integer>();
			te_map = ((HashMap<String, Integer>) session.getAttribute("uke_map"));
			request.setAttribute("te_map", te_map);
			System.out.println("te_map map size form req: " + te_map.size());

			ArrayList<String> UI_tek = new ArrayList<String>();
			ArrayList<Integer> UI_tevl = new ArrayList<Integer>();

			ValueComparator bvcc = new ValueComparator(te_map);
			TreeMap<String, Integer> te_sorted_map = new TreeMap<String, Integer>(bvcc);

			//System.out.println("unsorted map: " + te_map);
			te_sorted_map.putAll(te_map);

			List tekeys = new ArrayList(te_sorted_map.keySet());
			for (int i = 0; i < tekeys.size(); i++) {
				String tekey = tekeys.get(i).toString();
				Integer tevalue = te_map.get(tekey);
				if (i <= 4) {
					UI_tek.add(tekey);
					UI_tevl.add(tevalue);
				}
			}

			request.setAttribute("UI_tek", UI_tek);
			session.setAttribute("UI_tek", UI_tek);
			request.setAttribute("UI_tevl", UI_tevl);%>

google.charts.load('current', {	'packages' : [ 'corechart' ] });
google.charts.setOnLoadCallback(te_drawStuff);

function te_drawStuff() {

var data = new google.visualization.DataTable();
data.addColumn('string', 'Uniquekeys');
data.addColumn('number', 'ReaptedTimes');

// Create and populate the data table.
var jshostArray = [];
<%for (int j = 0; j < UI_tek.size(); j++) {%>
jshostArray.push("<%=UI_tek.get(j)%>");
<%}%>

var jsvalueArray = [];
<%for (int k = 0; k < UI_tevl.size(); k++) {%>
jsvalueArray.push("<%=UI_tevl.get(k)%>");<%}%>

	// Create and populate the data table.
		var hostnames = jshostArray.slice();
		var count = jsvalueArray.slice();

		for (i = 0; i < hostnames.length; i++) {
			data.addRow([ hostnames[i], parseInt(count[i]) ]);
		}

		var options = {
			title : 'Total# instances top 5 Error',
			width : 600,
			height: 350,
			is3D: true,
			backgroundColor : "#E6E6FA",
			tooltip: { isHtml: true }
		};

		// Instantiate and draw the chart for top 5 critical .
		var chart = new google.visualization.PieChart(document.getElementById('te_chart_div'));
		chart.draw(data, options);
	};
</script>

<!-- code to get top five bar  graph  wrt UK total key--->
<script type="text/javascript">
<%
		HashMap<String, Integer> tfc_map = new HashMap<String, Integer>();
			tfc_map = ((HashMap<String, Integer>) session.getAttribute("ukc_map"));
			request.setAttribute("tfc_map", tfc_map);
			System.out.println("tfc_map map size form req: " + tfc_map);

			ArrayList<String> UI_tfck = new ArrayList<String>();
			ArrayList<Integer> UI_tfcvl = new ArrayList<Integer>();

			ValueComparator tfc_bvc = new ValueComparator(tfc_map);
			TreeMap<String, Integer> tfc_sorted_map = new TreeMap<String, Integer>(tfc_bvc);

			//System.out.println("unsorted map: " + tc_map);
			tfc_sorted_map.putAll(tfc_map);

			List ckeys = new ArrayList(tfc_sorted_map.keySet());
			for (int i = 0; i < ckeys.size(); i++) {
				String tfckey = ckeys.get(i).toString();
				Integer tfcvalue = tfc_map.get(tfckey);
				if (i <= 4) {
					UI_tfck.add(tfckey);
					UI_tfcvl.add(tfcvalue);
				}
			}

			request.setAttribute("UI_tfck", UI_tfck);
			session.setAttribute("UI_tfck", UI_tfck);
			request.setAttribute("UI_tfcvl", UI_tfcvl);
%>

		google.charts.load('current', {	'packages' : [ 'bar' ] });
		google.charts.setOnLoadCallback(tc_drawStuff);
		
		function tc_drawStuff() {
		
		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Uniquekeys');
		data.addColumn('number', 'ReaptedTimes');
		
		// Create and populate the data table.
		var jshostArray = [];
		<%for (int j = 0; j < UI_tfck.size(); j++) {%>
		jshostArray.push("<%=UI_tfck.get(j)%>");
		<%}%>
		
		var jsvalueArray = [];
		<%for (int k = 0; k < UI_tfcvl.size(); k++) {%>
		jsvalueArray.push("<%=UI_tfcvl.get(k)%>");
		<%}%>
			// Create and populate the data table.
		var hostnames = jshostArray.slice();
		var count = jsvalueArray.slice();

		var data = new google.visualization.DataTable();
		data.addColumn('string', 'HOSTNAMES');
		data.addColumn('number', 'count');
		
		for (i = 0; i < hostnames.length; i++) {
			if((count[i]) != '0'){
				data.addRow([ hostnames[i], parseInt(count[i]) ]);
			}
		} 
		var view = new google.visualization.DataView(data);
		view.setColumns([0, 1, {
	        type: 'string',
	        role: 'annotation',
	        sourceColumn: 1,
	        calc: 'stringify'
	    }]);
		var options = {
		        title: 'TOP CRITICAL GRAPH',
		        isStacked: true,
		        height:400,
		        width : 600,
		        colors: ['#FF0000'],
		        bar: { groupWidth: '90%' },
		        legend: { position: "none"},
		        backgroundColor : "#E6E6FA",
		    	chartArea: {
		        	   top: 55,
		        	   height: '40%' ,
		        	}, 
		        hAxis:{
						title: 'CRITICAL SYSLOG',
						slantedText:true,
						slantedTextAngle:45,
				        titleTextStyle: {
				            color: '#FF0000',            
				          },
					},
					vAxis: {
				          title: 'COUNT',
				        	  titleTextStyle: {
						            color: '#FF0000',            
						          },
				        }
		}
		var chart = new google.visualization.ColumnChart(document.getElementById('top1_x_div'));
		chart.draw(view, options);
};
</script>

<!-- code to get top five bar  graph  wrt UK total key--->
<script type="text/javascript">
<%
	HashMap<String, Integer> tfe_map = new HashMap<String, Integer>();
	tfe_map = ((HashMap<String, Integer>) session.getAttribute("uke_map"));
	request.setAttribute("tfe_map", tfe_map);
	System.out.println("tfe_map map size form req: " + tfe_map.size());
	
	ArrayList<String> UI_tfek = new ArrayList<String>();
	ArrayList<Integer> UI_tfevl = new ArrayList<Integer>();
	
	ValueComparator tfe_bvc = new ValueComparator(tfe_map);
	TreeMap<String, Integer> tfe_sorted_map = new TreeMap<String, Integer>(tfe_bvc);
	
	//System.out.println("unsorted map: " + te_map);
	tfe_sorted_map.putAll(tfe_map);
	
	List ekeys = new ArrayList(tfe_sorted_map.keySet());
	for (int i = 0; i < ekeys.size(); i++) {
		String ekey = ekeys.get(i).toString();
		Integer evalue = tfe_map.get(ekey);
		if (i <= 4) {
			UI_tfek.add(ekey);
			UI_tfevl.add(evalue);
		}
	}
	
	request.setAttribute("UI_tfek", UI_tfek);
	session.setAttribute("UI_tfek", UI_tfek);
	request.setAttribute("UI_tfevl", UI_tfevl);
%>
google.charts.load('current', {	'packages' : [ 'bar' ] });
google.charts.setOnLoadCallback(tc_drawStuff);

function tc_drawStuff() {

var data = new google.visualization.DataTable();
data.addColumn('string', 'Uniquekeys');
data.addColumn('number', 'ReaptedTimes');

// Create and populate the data table.
var jshostArray = [];
<%for (int j = 0; j < UI_tfek.size(); j++) {%>
jshostArray.push("<%=UI_tfek.get(j)%>");
<%}%>

var jsvalueArray = [];
<%for (int k = 0; k < UI_tfevl.size(); k++) {%>
jsvalueArray.push("<%=UI_tfevl.get(k)%>");
<%}%>
	// Create and populate the data table.
var hostnames = jshostArray.slice();
var count = jsvalueArray.slice();

var data = new google.visualization.DataTable();
data.addColumn('string', 'HOSTNAMES');
data.addColumn('number', 'count');

for (i = 0; i < hostnames.length; i++) {
	if((count[i]) != '0'){
		data.addRow([ hostnames[i], parseInt(count[i]) ]);
	}
} 
var view = new google.visualization.DataView(data);
view.setColumns([0, 1, {
    type: 'string',
    role: 'annotation',
    sourceColumn: 1,
    calc: 'stringify'
}]);
var options = {
        title: 'TOP ERROR GRAPH',
        isStacked: true,
        height:400,
        width : 600,
        colors: ['#FFA500'],
        bar: { groupWidth: '90%' },
        legend: { position: "none"},
        backgroundColor : "#E6E6FA",
    	chartArea: {
        	   top: 55,
        	   height: '40%' ,
        	}, 
        hAxis:{
				title: 'ERROR SYSLOG',
				slantedText:true,
				slantedTextAngle:45,
		        titleTextStyle: {
		            color: '#FFA500',            
		          },
			},
			vAxis: {
		          title: 'COUNT',
		        	  titleTextStyle: {
				            color: '#FFA500',            
				          },
		        }
}
var chart = new google.visualization.ColumnChart(document.getElementById('top2_x_div'));
chart.draw(view, options);
};

</script>
</head>
<body>
	<span align="center"><jsp:include page="header.jsp"></jsp:include></span>
	<div align="right">
		<table align="right">
			<tr>
				<td><c:url value="/j_spring_security_logout" var="logoutUrl" />
					<form action="${logoutUrl}" method="post" id="logoutForm"></form> <c:if
						test="${pageContext.request.userPrincipal.name != null}">
						<h4>
							Welcome : ${pageContext.request.userPrincipal.name} | <a
								href="javascript:formSubmit()"> Logout</a>
						</h4>
					</c:if></td>
			</tr>
		</table>
	</div>
	<p align="left">
		<a href="/csv/upload"><label>GO Back&nbsp;</label></a>
	</p>
	<div>
		<table>
			<tr>
				<td colspan="3">
					<h4>Successfully Generated Graphs ...</h4>
				</td>
			</tr>
			<tr>
				<td>
					<h4>Click to view top five Bar
						Graphs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
				</td>
				<td>
				<td><a href="/csv/topcritical"><button
							class="btn btn-warning" type="button">Critical Graphs</button></a></td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/csv/toperror"><button
							class="btn btn-success" type="button">Error Graphs</button></a></td>
			</tr>
		</table>
	</div>
	<div>
		<table width="40%" align="left">
			<tr>
				<td style="">
					<h4 align="center" class="text-warning">Critical PieChart</h4>
					<div align="left" id="chart_div"
						style="width: 500px; height: 400px; padding-left: 30px;"></div>

				</td>
			</tr>
		</table>
		<table></table>
		<table width="40%" align="right">
			<tr>
				<td>
					<h4 align="center" class="text-warning">Error PieChart</h4>
					<div align="left" id="egchart_div"
						style="width: 450px; height: 400px;"></div>
				</td>
			</tr>
		</table>
	</div>
	<div>
		<table width="40%" align="left">
			<tr>
				<td>
					<h4 align="center" class="text-warning">Top 5 Critical WRT
						UniqueKey</h4>
					<div align="left" id="tc_chart_div"
						style="width: 500px; height: 400px; padding-left: 30px;"></div>
				</td>
			</tr>
		</table>
		<table width="40%" align="right">
			<tr>
				<td>
					<h4 align="center" class="text-warning">Top 5 Error WRT
						UniqueKey</h4>
					<div align="left" id="te_chart_div"
						style="width: 450px; height: 400px;"></div>
				</td>
			</tr>
		</table>
	</div>
	
	<div>
		<table>
			<tr>
				<td  width="40%" style="padding-left: 30px;">
				<h4 align="center" class="text-warning">Top 5 Critical Bar Graph WRT UniqueKey</h4>
					<div id="top1_x_div"></div>
				</td>
				<td></td>
				<td   width="40%" style="padding-right: 30px;">
				<h4 align="center" class="text-warning">Top 5 Error Bar Graph WRT UniqueKey</h4>
					<div id="top2_x_div"></div>
				</td>
			</tr>
		</table>
	</div>
	<br/>
</body>
</html>