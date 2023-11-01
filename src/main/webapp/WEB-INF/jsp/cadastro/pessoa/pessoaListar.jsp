<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<!-- Titulo da pgina -->
	<div class="table-responsive-lg pb-5 containerForm">
		<c:choose>
			<c:when test="${empty dados.LISTA}">
				<p>Não foi possível encontrar nenhum registro!</p>
			</c:when>
			<c:otherwise>
				<table class="table" id="tb-especie">
		          <thead>
		            <tr>
		              <th scope="col">Nome</th>
		              <th scope="col">E-mail</th>
		              <th scope="col">CPF</th>
		              <th scope="col">Telefone</th>
		              <th scope="col">Tipo</th>
		              <th scope="col">Usuário</th>
		              <th scope="col">Status</th>
		              <th scope="col">Ações</th>
		            </tr>
		          </thead>
		          <tbody>
		          	<c:forEach items="${dados.LISTA}" var="l">
		          		<tr>
		          			<td>${l.pes_nome}</td>
		          			<td>${l.pes_email}</td>
		          			<td>${l.pes_cpf}</td>
		          			<td>${l.pes_telefone}</td>
		          			<td>${l.tip_descricao}</td>
		          			<td><c:if test="${l.usr_id==0}">-</c:if><c:if test="${l.usr_id!=0}">${l.usr_id}</c:if></td>
		          			<td>							
								<div class="form-check form-switch">
									<input class="form-check-input" style="cursor: pointer;" type="checkbox" id="switchAtivo${l.pes_id}" <c:if test="${l.pes_statusDesc eq 'Ativo'}">checked</c:if> onchange="ativaInativaPessoa(${l.pes_id})">
									<label class="form-check-label" for="switchAtivo${l.pes_id}"></label>
								</div>
		          			</td>
		          			<td>
		          				<a href="javascript: editarPessoa(${l.pes_id})" class="btn btn-sm"><i class="bi bi-pencil-square"></i></a>
		          				<a href="javascript: subirDocumento(${l.pes_id}, '${l.pes_nome}', '${l.pes_documento}', '${l.pes_foto}')" class="btn btn-sm"><i class="bi bi-file-earmark-arrow-up"></i></a>
		          				<a href="javascript: qrCode(${l.pes_id}, '${l.pes_cpf}', '${l.pes_nome}')" class="btn btn-sm"><i class="bi bi-qr-code"></i></a>
		          			</td>
		          		</tr>
		          	</c:forEach>
		          </tbody>
		        </table>
	        </c:otherwise>
		</c:choose>
      </div>
<script>
$(document).ready(function (){
	//configurarTabela('tb-especie', false, false, false);
})

function ativaInativaPessoa(id){
	let param = {
			id: id,
			status: $("#switchAtivo"+id).attr("checked")=="checked" ? "N" : "S"
	}
	
	$.post("${pageContext.request.contextPath}/cadastro/pessoaStatus", param, function(retorno){
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
		pesquisarPessoa()
	})
}

function editarPessoa(id){
   	let params = {id: id}
   	
   	$("#modal-responsive").empty().html()
   	$("#modal-responsive").load("${pageContext.request.contextPath}/cadastro/pessoaEditar", params, function(){
   		$("#modal-editar-pessoa").modal("show")
   	})
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

function qrCode(id, cpf, nome){
	let param = {
			qrText: id+"/"+cpf,
			nome: nome
	}
	
	$("#modal-responsive").empty().html()
   	$("#modal-responsive").load("${pageContext.request.contextPath}/cadastro/qrCode", param, function(){
   		$("#modal-qrCode").modal("show")
   	})
}
</script>