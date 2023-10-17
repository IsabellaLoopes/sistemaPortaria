<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="utf-8" />

<tiles:insertDefinition name="menu">

	<tiles:putAttribute name="body">
		<h1 class="nomeTopo">MENU</h1>
		<div class="containerForm">
			<form class="formPesquisa" id="menu">
				<div class="row">
					<div class="col-12 col-sm-12 col-md-2 col-lg-2">
						<label for="status"><b>Status:</b></label> <select id="status"
							class="form-select">
							<option value="">Todos</option>
							<option value="S">Ativo</option>
							<option value="N">Inativo</option>
						</select>
					</div>
				</div>
				<div class="row">
					<button type="button" class="btn btn-form" onclick="pesquisarMenu()">
						Pesquisar <i class="fa fa-search"></i>
					</button>
				</div>
			</form>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="footer">
		<script>
		$(document).ready(function(){
			menuPequeno();
		})
		
		function pesquisarMenu(){
			let param = {
					status: $("#menu #status").val(),
			}
			$("#table-responsive").empty();
			$("#table-responsive").load("${pageContext.request.contextPath}/adm/menuListar", param);
		}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>