<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<meta charset="utf-8" />

<tiles:insertDefinition name="menu">
	
	<tiles:putAttribute name="body">
		<div class="containerBanner">
			<img style="width:100%;"src="${pageContext.request.contextPath}/img/banner-principal.png">
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="footer">
		<script>
			$(document).ready(function(){
				menuGrande();
			})
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>