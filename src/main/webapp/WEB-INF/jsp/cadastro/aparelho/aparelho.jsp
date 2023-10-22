<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="utf-8" />

<tiles:insertDefinition name="menu">

	<tiles:putAttribute name="body">
		<h1 class="nomeTopo">APARELHO</h1>
		<div class="containerForm">
			<form class="formPesquisa" id="aparelho">
				<div class="row">
					<div class="col-12 col-sm-12 col-md-2 col-lg-2">
						<label for="status"><b>Status:</b></label> <select id="status"
							class="form-select">
							<option value="">Todos</option>
							<option value="S">Ativo</option>
							<option value="N">Inativo</option>
						</select>
					</div>
					<div class="col-12 col-sm-12 col-md-2 col-lg-2">
						<label for="tipoOperacao"><b>Tipo Operação:</b></label> <select id="tipoOperacao"
							class="form-select">
							<option value="">Todos</option>
							<c:forEach items="${dados.DATA.LISTA}" var="t">
								<option value="${t.tip_id}">${t.tip_descricao}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="row">
					<button type="button" class="btn btn-form" onclick="pesquisarAparelho()">
						Pesquisar <i class="fa fa-search"></i>
					</button>
					<button type="button" class="btn btn-form" onclick="incluirAparelho()">
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
		
		function incluirAparelho(){
			$("#modal-responsive").load("${pageContext.request.contextPath}/cadastro/aparelhoIncluir", function(){
				$("#modal-incluir-aparelho").modal("show");
			});
		}
		
		function pesquisarAparelho(){
			let param = {
					tipoOperacao: $("#aparelho #tipoOperacao").val(),
					status: $("#aparelho #status").val(),
			}
			$("#table-responsive").empty();
			$("#table-responsive").load("${pageContext.request.contextPath}/cadastro/aparelhoListar", param);
		}
		
		function salvarAparelho(id=0){
			if(validar('#aparelhoIncluir')){
				let param = {
						id: id,
						descricao: $("#aparelhoIncluir #descricao").val(),
						tipoOperacao: $("#aparelhoIncluir #tipoOperacao").val(),
						ip: $("#aparelhoIncluir #ip").val()
				}
				
				$.post("${pageContext.request.contextPath}/cadastro/aparelhoSalvar", param, function(retorno){
					let obj = JSON.parse(retorno);
					
					if(obj.DATA.erro == 0){
						if(id == 0){
							$("#modal-incluir-aparelho").modal("hide");
						}else {
							$("#modal-editar-aparelho").modal("hide");
						}
						
						Swal.fire({
							  title: 'Sucesso!',
							  text: obj.DATA.mensagem,
							  icon: 'success',
							  confirmButtonText: 'Ok'
							})
						pesquisarAparelho()
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