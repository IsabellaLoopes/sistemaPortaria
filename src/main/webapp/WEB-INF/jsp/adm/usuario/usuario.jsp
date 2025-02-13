<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="utf-8" />

<tiles:insertDefinition name="menu">

	<tiles:putAttribute name="body">
		<h1 class="nomeTopo">USU�RIO</h1>
		<div class="containerForm">
			<form class="formPesquisa" id="usuario">
				<div class="row">
					<div class="col-12 col-sm-12 col-md-4 col-lg-4">
						<label for="nome"><b>Nome:</b></label> <input id="nome"
							class="form-control" type="text" />
					</div>
					<div class="col-12 col-sm-12 col-md-5 col-lg-4">
						<label for="cpf"><b>CPF:</b></label> <input id="cpf"
							class="form-control" type="text" />
					</div>
					<!-- <div class="col-12 col-sm-12 col-md-2 col-lg-2">
						<label for="tipoPessoa"><b>Tipo Pessoa:</b></label> <select
							id="tipoPessoa" class="form-select">
							<option value="">Todos</option>
							<c:forEach items="${dados.DATA.LISTA}" var="t">
								<option value="${t.tip_sigla}">${t.tip_descricao}</option>
							</c:forEach>
						</select>
					</div>  -->
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
					<button type="button" class="btn btn-form" onclick="pesquisarUsuario()">
						Pesquisar <i class="fa fa-search"></i>
					</button>
					<button type="button" class="btn btn-form" onclick="incluirUsuario()">
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
		
		function incluirUsuario(){
			$("#modal-responsive").load("${pageContext.request.contextPath}/adm/usuarioIncluir", function(){
				$("#modal-incluir-usuario").modal("show");
			});
		}
		
		function pesquisarUsuario(){
			let param = {
					nome: $("#usuario #nome").val(),
					//tipo: $("#usuario #tipoPessoa").val(),
					tipo: 'U',
					cpf: $("#usuario #cpf").val(),
					status: $("#usuario #status").val(),
			}
			$("#table-responsive").empty();
			$("#table-responsive").load("${pageContext.request.contextPath}/adm/usuarioListar", param);
		}
		
		function salvarUsuario(id=0){
			if(validar('#usuarioIncluir')){
				let param = {
						id: id,
						nome: $("#usuarioIncluir #nome").val(),
						cpf: $("#usuarioIncluir #cpf").val(),
						//tipoPessoa: $("#usuarioIncluir #tipoPessoa").val(),
						tipoPessoa: 'U',
						email: $("#usuarioIncluir #email").val(),
						telParticular: $("#usuarioIncluir #telParticular").val(),
						telCorporativo: $("#usuarioIncluir #telCorporativo").val(),
						apelido: $("#usuarioIncluir #apelido").val(),
						//senha: $("#usuarioIncluir #senha").val(),
						//senhaConfirmar: $("#usuarioIncluir #senhaConfirmar").val()
				}
				
				$.post("${pageContext.request.contextPath}/adm/usuarioSalvar", param, function(retorno){
					let obj = JSON.parse(retorno);
					
					if(obj.DATA.erro == 0){
						if(id == 0){
							$("#modal-incluir-usuario").modal("hide");
						}else {
							$("#modal-editar-usuario").modal("hide");
						}
						
						Swal.fire({
							  title: 'Sucesso!',
							  text: obj.DATA.mensagem,
							  icon: 'success',
							  confirmButtonText: 'Ok'
							})
						pesquisarUsuario()
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