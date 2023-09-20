<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<meta charset="utf-8" />

<tiles:insertDefinition name="menu">
	
	<tiles:putAttribute name="body">
		<p style="margin-left:300px">hi sss</p>
	</tiles:putAttribute>
	<tiles:putAttribute name="footer">
		<script>
			$(document).ready(function(){
				menuGrande();
			})
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>