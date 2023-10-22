<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="utf-8" />

<tiles:insertDefinition name="menu">

	<tiles:putAttribute name="body">
		<h1 class="nomeTopo">DASHBOARD</h1>
	</tiles:putAttribute>
	<tiles:putAttribute name="footer">
		<script>
		$(document).ready(function(){
			menuPequeno();
			pesquisarDash();
		})
		
		function pesquisarDash(){
			$("#table-responsive").empty();
			$("#table-responsive").load("${pageContext.request.contextPath}/dashboard/dashboardListarEntrada", {tipoOperacao: 'E'});
		
			$("#table-responsive1").empty();
			$("#table-responsive1").load("${pageContext.request.contextPath}/dashboard/dashboardListarSaida", {tipoOperacao: 'S'});
		}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>