<h1>Substitute User</h1>
<form action="" method="post">
	<p>Select or enter uname.</p>
	<select name="uid">
		<option value=""></option>
		<{foreach from=$users item="user"}>
			<option value="<{$user.uid}>"><{$user.uname|escape}><{if $user.name}>(<{$user.name|escape}>)<{/if}></option>
		<{/foreach}>
	</select>
	<span>uname: </span><input type="text" name="uname" size="15"><br>
	<input type="submit" value="submit">
</form>
<{if $nowUser}>
	<p>Right now, you are logged in as <a href="<{$xoops_url}>/userinfo.php?uid=<{$nowUser.uid}>"><{$nowUser.uname}></a></p>
<{/if}>
