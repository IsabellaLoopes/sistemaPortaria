<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="utf-8" />

<tiles:insertDefinition name="menu">

	<tiles:putAttribute name="body">
		<h1 class="nomeTopo">PERFIL</h1>
		<div class="containerForm">
			<form class="formPesquisa" id="perfilEditar">
				<div class="row">
					<div class="col-12 col-sm-12 col-md-6 col-lg-3">
						<label for="nome"><b>Nome:</b></label> <input id="nome"
							class="form-control validar" type="text" value="${dados.DATA.PESSOA.pes_nome}"/>
					</div>
					<div class="col-12 col-sm-12 col-md-6 col-lg-3">
						<label for="cpf"><b>CPF:</b></label> <input id="cpf"
							class="form-control validar" type="text" placeholder="Ex 124.356.987-01" value="${dados.DATA.PESSOA.pes_cpf}" DISABLED/>
					</div>
					<div class="col-12 col-sm-12 col-md-6 col-lg-3">
						<label for="tipoPessoa"><b>Tipo Pessoa:</b></label> <select
							id="tipoPessoa" class="form-select validar" onchange="mudarTipo()" DISABLED>
							<c:forEach items="${dados.DATA.LISTA}" var="t">
								<option value="${t.tip_sigla}" <c:if test="${dados.DATA.PESSOA.pes_tipo == t.tip_sigla}">SELECTED</c:if>>${t.tip_descricao}</option>
							</c:forEach>
						</select>
					</div> 
					<div class="col-12 col-sm-12 col-md-6 col-lg-3">
						<label for="email"><b>Email:</b></label> <input id="email"
							class="form-control validar" type="text" value="${dados.DATA.PESSOA.pes_email}"/>
					</div>
					<div class="col-12 col-sm-12 col-md-6 col-lg-3">
						<label for="tel"><b>Telefone:</b></label> <input id="tel"
							class="form-control" type="text" value="${dados.DATA.PESSOA.pes_telefone}"/>
					</div>
					<div class="col-12 col-sm-12 col-md-6 col-lg-3 d-none" id="divUsuario">
						<label for="usr"><b>Usuário:</b></label> <select
							id="usr" class="form-select" DISABLED>
							<option value="0">Selecione...</option>
							<c:forEach items="${dados.DATA.USUARIOS}" var="t">
								<option value="${t.usr_id}" <c:if test="${dados.DATA.PESSOA.pes_usr_id == t.usr_id}">SELECTED</c:if>>${t.usr_apelido} - ${t.usr_nome}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-12 col-sm-12 col-md-3 col-lg-3 mt-2">
						<button type="button" class="btn btn-form" onclick="salvarPerfil(${dados.DATA.PESSOA.pes_id})">Atualizar <i class="fa fa-arrow-right"></i></button>      
					</div>
				</div>
				<br><br>
				<div class="row">
					<div class="col-12 col-sm-12 col-md-6 col-lg-3">
						<label for="tel"><b>Documento</b></label>
						<img style="width: 100% !important" src="${pageContext.request.contextPath}/vizualizar/imagem/doc?id=${dados.PARAMETROS.id}">
					</div>
					<div class="col-12 col-sm-12 col-md-6 col-lg-3">
						<label for="tel"><b>Foto</b></label>
						<img style="width: 100% !important" src="${pageContext.request.contextPath}/vizualizar/imagem/foto?id=${dados.PARAMETROS.id}">
					</div>
					<div class="col-12 col-sm-12 col-md-6 col-lg-3">
						<label for="tel"><b>QR Code</b></label>
						<img style="width: 100% !important" src="${pageContext.request.contextPath}/vizualizar/qrCode?qrText=${dados.PARAMETROS.qrText}">
					</div>
					<div class="col-12 col-sm-12 col-md-12 col-lg-12 mt-2">
						<button type="button" class="btn btn-form" onclick="subirDocumento(${dados.PARAMETROS.id}, '${dados.DATA.PESSOA.pes_nome}', '${dados.DATA.PESSOA.possuiDoc}', '${dados.DATA.PESSOA.possuiFoto}')">Editar Foto <i class="fa fa-arrow-right"></i></button>      
					</div>
				</div>
			</form>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="footer">
		<script>
		$(document).ready(function(){
			menuPequeno();
		})
		
		function salvarPerfil(id=0){
			if(validar('#perfilEditar')){
				let param = {
						id: id,
						nome: $("#perfilEditar #nome").val(),
						email: $("#perfilEditar #email").val(),
						tel: $("#perfilEditar #tel").val()
				}
				
				$.post("${pageContext.request.contextPath}/perfil/perfilSalvar", param, function(retorno){
					let obj = JSON.parse(retorno);
					
					if(obj.DATA.erro == 0){
						Swal.fire({
							  title: 'Sucesso!',
							  text: obj.DATA.mensagem,
							  icon: 'success',
							  confirmButtonText: 'Ok'
							})
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
		
		function subirDocumento(id, usuario, documento, foto){
			let params = {
					id: id, 
					usuario: usuario,
					documento: documento,
					foto: foto
			}
			
		   	$("#modal-responsive").empty().html()
		   	$("#modal-responsive").load("${pageContext.request.contextPath}/cadastro/subirDocumento", params, function(){
		   		$("#modal-subir-documento").modal("show")
		   	})
		}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>