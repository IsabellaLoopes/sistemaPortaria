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
		              <th scope="col">Menu</th>
		              <th scope="col">SubMenu</th>
		              <th scope="col">Status</th>
		              <th scope="col">Ações</th>
		            </tr>
		          </thead>
		          <tbody>
		          	<c:forEach items="${dados.LISTA}" var="l">
		          		<tr>
		          			<td><c:if test="${l.men_menu == 0}">${l.men_descricao}</c:if></td>
		          			<td><c:if test="${l.men_menu != 0}">${l.men_descricao}</c:if></td>
		          			<td>
		          				<div class="form-check form-switch">
									<input class="form-check-input" style="cursor: pointer;" type="checkbox" id="switchAtivo${l.men_id}" <c:if test="${l.men_status eq 'S'}">checked</c:if> onchange="ativaInativaMenu(${l.men_id})">
									<label class="form-check-label" for="switchAtivo${l.men_id}"></label>
								</div>
		          			</td>
		          			<td>
		          				<a href="javascript: editarUsuario(${l.usr_id})" class="btn btn-sm"><i class="bi bi-pencil-square"></i></a>
		          				<a href="javascript: editarUsuario(${l.usr_id})" class="btn btn-sm"><i class="bi bi-key-fill"></i></a>
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

function ativaInativaMenu(id){
	let param = {
			id: id,
			status: $("#switchAtivo"+id).attr("checked")=="checked" ? "N" : "S"
	}
	
	$.post("${pageContext.request.contextPath}/adm/statusMenu", param, function(retorno){
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
			pesquisarUsuario()
		}
	})
}

function editarUsuario(id){
   	let params = {id: id}
   	
   	$("#modal-responsive").empty().html()
   	$("#modal-responsive").load("${pageContext.request.contextPath}/adm/usuarioEditar", params, function(){
   		$("#modal-editar-usuario").modal("show")
   	})
}
</script>