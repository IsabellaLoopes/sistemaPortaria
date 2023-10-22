<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="utf-8" />

<tiles:insertDefinition name="menu">

	<tiles:putAttribute name="body">
		<h1 class="nomeTopo">VISITA</h1>
		<div class="containerForm">
			<form class="formPesquisa" id="visita">
				<div class="row">
					<div class="col-12 col-sm-12 col-md-3 col-lg-3">
						<label for="data"><b>Data:</b></label> <input id="data"
							class="form-control" type="date" value="${data}"/>
					</div>
					<div class="col-12 col-sm-12 col-md-2 col-lg-2">
						<label for="tipoPessoa"><b>Tipo Pessoa:</b></label> <select id="tipoPessoa"
							class="form-select">
							<option value="">Todos</option>
							<c:forEach items="${dados.DATA.TIPO}" var="t">
								<option value="${t.tip_sigla}">${t.tip_descricao}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="row">
					<button type="button" class="btn btn-form" onclick="pesquisarVisita()">
						Pesquisar <i class="fa fa-search"></i>
					</button>
					<button type="button" class="btn btn-form" onclick="incluirVisita()">
						Incluir <i class="fa fa-plus"></i>
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
		
		function incluirVisita(){
			$("#modal-responsive").load("${pageContext.request.contextPath}/cadastro/visitaIncluir", function(){
				$("#modal-incluir-visita").modal("show");
			});
		}
		
		function pesquisarVisita(){
			let param = {
					data: $("#visita #data").val(),
					tipoPessoa: $("#visita #tipoPessoa").val()
			}
			$("#table-responsive").empty();
			$("#table-responsive").load("${pageContext.request.contextPath}/cadastro/visitaListar", param);
		}
		
		function salvarVisita(id=0){
			if(validar('#permissaoIncluir')){
				let param = {
						id: id,
						aparelho: $("#permissaoIncluir #aparelho").val(),
						tipoPessoa: $("#permissaoIncluir #tipoPessoa").val() || 0,
						pessoa: $("#permissaoIncluir #pessoa").val() || 0
				}
				
				$.post("${pageContext.request.contextPath}/cadastro/permissaoSalvar", param, function(retorno){
					let obj = JSON.parse(retorno);
					
					if(obj.DATA.erro == 0){
						if(id == 0){
							$("#modal-incluir-permissao").modal("hide");
						}
						
						Swal.fire({
							  title: 'Sucesso!',
							  text: obj.DATA.mensagem,
							  icon: 'success',
							  confirmButtonText: 'Ok'
							})
						pesquisarPermissao()
					} else{
						Swal.fire({
							  title: 'Ops!',
							  text: obj.DATA.mensagem,
							  icon: 'error',
							  confirmButtonText: 'Ok'
							})
					}
				});
			}
		}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>