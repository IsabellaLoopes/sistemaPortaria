<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="utf-8" />

<tiles:insertDefinition name="menu">

	<tiles:putAttribute name="body">
		<h1 class="nomeTopo">RELATÓRIO DE ACESSO</h1>
		<div class="containerForm">
			<form class="formPesquisa" id="relatorioAcesso">
				<div class="row">
					<div class="col-12 col-sm-12 col-md-3 col-lg-3">
						<label for="data"><b>Data:</b></label> <input id="data"
							class="form-control" type="date" value="${data}"/>
					</div>
					<div class="col-12 col-sm-12 col-md-2 col-lg-2">
						<label for="aparelho"><b>Aparelho:</b></label> <select id="aparelho"
							class="form-select">
							<option value="0">Todos</option>
							<c:forEach items="${dados.DATA.APARELHO}" var="t">
								<option value="${t.apa_id}">${t.apa_descricao}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-12 col-sm-12 col-md-2 col-lg-2">
						<label for="pessoa"><b>Pessoa:</b></label> <select id="pessoa"
							class="form-select">
							<option value="0">Todos</option>
							<c:forEach items="${dados.DATA.PESSOA}" var="t">
								<option value="${t.pes_id}">${t.pes_nome}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-12 col-sm-12 col-md-3 col-lg-3">
						<label for="tipoPessoa"><b>Tipo Pessoa:</b></label> <select id="tipoPessoa"
							class="form-select">
							<option value="">Todos</option>
							<c:forEach items="${dados.DATA.TIPO}" var="t">
								<option value="${t.tip_sigla}">${t.tip_descricao}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-12 col-sm-12 col-md-2 col-lg-2">
						<label for="situacao"><b>Situação:</b></label> <select id="situacao"
							class="form-select">
							<option value="-2">Todos</option>
							<option value="0">Liberado</option>
							<option value="-1">Bloqueado</option>							
						</select>
					</div>
				</div>
				<div class="row">
					<button type="button" class="btn btn-form" onclick="pesquisarLog()">
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
		
		function pesquisarLog(){
			let param = {
					data: $("#relatorioAcesso #data").val(),
					aparelho: $("#relatorioAcesso #aparelho").val(),
					tipoPessoa: $("#relatorioAcesso #tipoPessoa").val(),
					pessoa: $("#relatorioAcesso #pessoa").val(),
					situacao: $("#relatorioAcesso #situacao").val(),
			}
			$("#table-responsive").empty();
			$("#table-responsive").load("${pageContext.request.contextPath}/historico/relatorioAcessoListar", param);
		}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>