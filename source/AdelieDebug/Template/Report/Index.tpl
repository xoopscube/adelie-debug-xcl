<style><{$css}></style>
<div class="adelieDebug">
	<p class="h1">
		<span>Adelie Debug</span>
		<{if $isBuild}>
			<span style="font-size: 12px;">(Build <{'YmdHis'|date:$buildTime}>)</sapn>
		<{else}>
			<span style="font-size: 12px;">(Source)</sapn>
		<{/if}>
	</p>
	<p class="h2">Errors</p>
	<{foreach from=$errorSummary key="typeName" item="ids"}>
		<div class="msgError">
			<strong><{$typeName}> (<{$ids|@count}>)</strong>
			<span>...</span>
			<{foreach from=$ids item="id"}>
				<a href="#adelieDebugLogId<{$id}>" style="margin: 10px;">#<{$id}></a>
			<{/foreach}>
		</div>
	<{foreachelse}>
		<div class="msgSuccess">There is no error.</div>
	<{/foreach}>
	
	<p class="h3">Cheat Sheet</p>
	<div class="adelieDebugHelp">
		<span>adump([mixed[, mixed]])</span>
		<span>atrace()</span>
		<span>awhich(object|string)</span>
		<span>asynop(object|string)</span>
		<{*<span class="adelieDebugHelpMore"><a href="<{$xoops_url}>/index.php/debug/help/">more…</a></span>*}>
	</div>
	
	<div class="adelieDebugClearBoth"></div>

	<p class="h2">Timeline</p>
	<div id="adelieDebugPhpErrors">
		<table class="data">
			<tr>
				<th>ID</th>
				<th>ms</th>
				<th>Type</th>
				<th>Message</th>
			</tr>
		<{assign var="lastTimeRate" value=0}>
		<{foreach from=$logs item="log"}>
			<tr>
				<td style="width: 10px;" id="adelieDebugLogId<{$log.id}>"><{$log.id}></td>
				<td style="width: 10px;"><{$log.ms}></td>
				<td><{$log.typeName}></td>
				<td>
					<{if $log.typeName == 'DUMP'}>
						<{$log.message}>
					<{elseif $log.typeName == 'SYNOPSYS'}>
						<{$log.message}>
					<{elseif $log.typeName == 'DELEGATE'}>
						<div style="font-size:12px;"><{$log.message|escape}></div>
					<{elseif $log.typeName == 'SQL'}>
						<{math equation="this - last" this=$log.timeRate last=$lastTimeRate assign="increce"}>
						<{strip}>
						<pre class="info <{$log.typeName}>" style="position:relative;">
							<div style="position: relative; z-index: 1;"><{$log.message|escape}></div>
							<div style="height: 100%; width: <{$log.timeRate}>px; background: #c5d9a3; position: absolute; top: 0; left: 0;"></div><{* TODO >> move to css *}>
						</pre>
						<{/strip}>
						<{if $log.info}>
							<pre><{$log.info|escape}></pre>
						<{/if}>
						<{assign var="lastTimeRate" value=$log.timeRate}>
					<{else}>
						<pre class="info <{$log.typeName}>"><{$log.message|escape}></pre>
						<{if $log.info}>
							<pre><{$log.info|escape}></pre>
						<{/if}>
					<{/if}>
				</td>
			</tr>
		<{/foreach}>
		</table>
	</div>

	<p class="h2">Sent Headers</p>
	<div id="adelieDebugSentHeaders">
		<{strip}>
		<pre class="console">
			<{foreach from=$sentHeaders item="header"}>
				<{$header}><br />
			<{/foreach}>
		</pre>
		<{/strip}>
	</div>
	<p class="h2">Requests</p>
	<div id="adelieDebugRequest">
		<{foreach from=$requests key="name" item="request"}>
			<p class="h3"><{$name}></p>
			<{if $request}>
				<table class="data">
					<tr>
						<th>Key</th>
						<th>Value</th>
					</tr>
					<{foreach from=$request key="key" item="value"}>
						<tr>
							<td><{$key}></td>
							<td><{$value|@var_dump}></td>
						</tr>
					<{/foreach}>
				</table>
			<{else}>
				<p>There is no values.</p>
			<{/if}>
		<{/foreach}>
	</div>
	<p class="h2">PHP Information</p>
	<{foreach from=$phpInfo key="categoryName" item="info"}>
		<p class="h3"><{$categoryName|ucwords}></p>
		<{if $info}>
			<table class="data">
				<tr>
					<th>Key</th>
					<th>Value</th>
				</tr>
				<{foreach from=$info key="key" item="value"}>
				<tr>
					<td><{$key}></td>
					<td><{$value}></td>
				</tr>
				<{/foreach}>
			</table>
		<{else}>
			<p>There is no values.</p>
		<{/if}>
	<{/foreach}>
</div>