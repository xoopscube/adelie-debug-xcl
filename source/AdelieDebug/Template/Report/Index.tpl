<script type="text/javascript">
    if (typeof jQuery == 'undefined') {
        // Fallback for CDN in case of Fatal error: Uncaught TypeError
    document.write(unescape("%3Cscript src='https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
}
</script>
<style><{$css}></style>
<script><{$js}></script>


<{* Capture Result and Total of Errors to show in the menu *}>
<{capture name="inResult"}>
<{foreach from=$errorSummary key="typeName" item="ids"}>
    <div class="msgError">
        <strong><{$typeName}> [ <{capture name="inError"}><{$ids|@count}><{/capture}><{$smarty.capture.inError}> ]</strong>
        <span>...</span>
        <{foreach from=$ids item="id"}>
        <a href="#adelieDebugLogId<{$id}>" style="margin: 10px;" onclick="javascript:document.getElementById('adelieDebugDetail').style.display='block'">#<{$id}></a>
        <{/foreach}>
    </div>
    <{foreachelse}>
    <div class="msgSuccess">There is no error.</div>
    <{/foreach}>
<{/capture}>


<div id="xhelper-main">

    <div id="xhelper-menu">
        <a href="#adelie">Adelie Debug <{if $smarty.capture.inError ne ""}><span><{$smarty.capture.inError}></span><{/if}></a>
        <a href="#kint">Kint</a>
    </div>


    <div id="adelie_view">

        <div id="viewTitle">

            <div class="title">
                Adelie Debug - <small> <{if $isAdmin}>Admin<{else}>Safe<{/if}> mode</small>
            </div>

            <div id="viewControl">
                <button id="about" aria-label="send email"><svg xmlns="http://www.w3.org/2000/svg" role="img" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M12 3a9 9 0 1 0 9 9a9 9 0 0 0-9-9Zm0 16.5a7.5 7.5 0 1 1 7.5-7.5a7.5 7.5 0 0 1-7.5 7.5Z"/><path fill="currentColor" d="M9.7 7.7a3.25 3.25 0 0 0-.95 2.3a.75.75 0 0 0 1.5 0a1.74 1.74 0 0 1 .51-1.24a1.8 1.8 0 0 1 2.48 0a1.75 1.75 0 0 1-1.24 3a.76.76 0 0 0-.75.75v1a.75.75 0 0 0 1.5 0v-.34a3.19 3.19 0 0 0 1.55-.86a3.26 3.26 0 0 0 0-4.6a3.34 3.34 0 0 0-4.6-.01Z"/><circle cx="12" cy="16.25" r="1.25" fill="currentColor"/></svg></button>
                <button id="maximize" aria-label="send email"><svg xmlns="http://www.w3.org/2000/svg" role="img" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M18 20.75h-6a.75.75 0 0 1 0-1.5h6A1.25 1.25 0 0 0 19.25 18V6A1.25 1.25 0 0 0 18 4.75H6A1.25 1.25 0 0 0 4.75 6v6a.75.75 0 0 1-1.5 0V6A2.75 2.75 0 0 1 6 3.25h12A2.75 2.75 0 0 1 20.75 6v12A2.75 2.75 0 0 1 18 20.75Z"/><path fill="currentColor" d="M16 12.75a.76.76 0 0 1-.75-.75V8.75H12a.75.75 0 0 1 0-1.5h4a.76.76 0 0 1 .75.75v4a.76.76 0 0 1-.75.75Z"/><path fill="currentColor" d="M11.5 13.25A.74.74 0 0 1 11 13a.75.75 0 0 1 0-1l4.5-4.5a.75.75 0 0 1 1.06 1.06L12 13a.74.74 0 0 1-.5.25ZM8 20.75H5A1.76 1.76 0 0 1 3.25 19v-3A1.76 1.76 0 0 1 5 14.25h3A1.76 1.76 0 0 1 9.75 16v3A1.76 1.76 0 0 1 8 20.75Zm-3-5a.25.25 0 0 0-.25.25v3a.25.25 0 0 0 .25.25h3a.25.25 0 0 0 .25-.25v-3a.25.25 0 0 0-.25-.25Z"/></svg></button>
                <button id="minimize" aria-label="send email"><svg xmlns="http://www.w3.org/2000/svg" role="img" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M18 3.25H6A2.75 2.75 0 0 0 3.25 6v6a.75.75 0 0 0 1.5 0V6A1.25 1.25 0 0 1 6 4.75h12A1.25 1.25 0 0 1 19.25 6v12A1.25 1.25 0 0 1 18 19.25h-6a.75.75 0 0 0 0 1.5h6A2.75 2.75 0 0 0 20.75 18V6A2.75 2.75 0 0 0 18 3.25Z"/><path fill="currentColor" d="M11.21 13.19a.75.75 0 0 0 .29.06h4a.75.75 0 0 0 0-1.5h-2.19l3.22-3.22a.75.75 0 0 0-1.06-1.06l-3.22 3.22V8.5a.75.75 0 0 0-1.5 0v4a.75.75 0 0 0 .06.29a.71.71 0 0 0 .4.4ZM8 14.25H5A1.76 1.76 0 0 0 3.25 16v3A1.76 1.76 0 0 0 5 20.75h3A1.76 1.76 0 0 0 9.75 19v-3A1.76 1.76 0 0 0 8 14.25ZM8.25 19a.25.25 0 0 1-.25.25H5a.25.25 0 0 1-.25-.25v-3a.25.25 0 0 1 .25-.25h3a.25.25 0 0 1 .25.25Z"/></svg></button>
            </div>

        </div>
        <{* viewTitle *}>

        <div class="adelieDebug">

		<h4>Report</h4>

            <{$smarty.capture.inResult}>

        <p>
        <a class="btnReport" onclick="javascript:document.getElementById('adelieDebugDetail').style.display='block'">
            <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="18px" height="18px" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M12 14.5a.74.74 0 0 1-.53-.22L8 10.78a.75.75 0 0 1 1-1.06l3 3l3-3a.75.75 0 0 1 1 1.06l-3.5 3.5a.74.74 0 0 1-.5.22Z"/></svg>
            open details </a>
        <a class="btnReport" onclick="javascript:document.getElementById('adelieDebugDetail').style.display='none'">
            <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="18px" height="18px" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M15.5 14.5a.74.74 0 0 1-.53-.22l-3-3l-3 3A.75.75 0 0 1 8 13.22l3.5-3.5a.75.75 0 0 1 1.06 0l3.5 3.5a.75.75 0 0 1 0 1.06a.74.74 0 0 1-.56.22Z"/></svg>
            close details </a>
        </p>

		<div style="display:none;" id="adelieDebugDetail">

           <details>
           <summary><h3>Timeline</h3></summary>

            <div id="adelieDebugPhpErrors">
            <table class="data">
                <tr>
                    <th>ID</th>
                    <th>ms</th>
                    <th>Type</th>
                    <th>Message</th>
                </tr>
            <{foreach from=$logs item="log"}>
                <tr>
                    <td style="width: 10px;" id="adelieDebugLogId<{$log.id}>"><{$log.id}></td>
                    <td style="width: 10px;"><{$log.ms}></td>
                    <td><{$log.typeName}></td>
                    <td>
                        <{if $isAdmin}>
                            <{assign var="message" value=$log.message}>
                            <{assign var="info" value=$log.info}>
                        <{else}>
                            <{assign var="message" value=$log.message|replace:$sourceDir:'(adelie)'|replace:$htmlDir:'(html)'|replace:$trustDir:'(trust)'|replace:$sqlPrefix:'(prefix)'}>
                            <{assign var="info" value=$log.info|replace:$sourceDir:'(adelie)'|replace:$htmlDir:'(html)'|replace:$trustDir:'(trust)'|replace:$sqlPrefix:'(prefix)'}>
                        <{/if}>
                        <{if $log.typeName == 'DUMP'}>
                            <{$message}>
                        <{elseif $log.typeName == 'SYNOPSYS'}>
                            <{$message}>
                        <{elseif $log.typeName == 'DELEGATE'}>
                            <div style="font-size:12px;"><{$message|escape}></div>
                        <{elseif $log.typeName == 'SQL'}>
                            <{strip}>
                            <pre class="info <{$log.typeName}>" style="position:relative;">
                                <div style="height: 100%; width: <{$log.timePer}>%; background:#375215;position:absolute;top:0;left:0;"></div><{* TODO >> move to css *}>
                                <div style="position: relative; "><{$message|escape}></div>
                            </pre>
                            <{/strip}>
                            <{if $log.info}>
                                <pre><{$info|escape}></pre>
                            <{/if}>
                        <{else}>
                            <pre class="info <{$log.typeName}>"><{$message|escape}></pre>
                            <{if $log.info}>
                                <pre><{$info|escape}></pre>
                            <{/if}>
                        <{/if}>
                    </td>
                </tr>
            <{/foreach}>
            </table>
            </div>
            </details>
            <{*  phpErrors  *}>

            <details>
            <summary><h3>Sent Headers</h3></summary>

            <div id="adelieDebugSentHeaders">
                <{strip}>
                <pre class="console">
                    <{foreach from=$sentHeaders item="header"}>
                        <{$header}><br>
                    <{/foreach}>
                </pre>
                <{/strip}>
            </div>
            </details>
            <{*  sentHeaders  *}>

            <details>
            <summary><h3>Requests</h3></summary>
            <div id="adelieDebugRequest">
                <{foreach from=$requests key="name" item="request"}>
                    <{if $isAdmin || ($name != '$_SERVER' && $name != '$_SESSION')}>
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
                    <{/if}>
                <{/foreach}>
            </div>
            </details>
            <{*  debugRequest  *}>


            <details>
            <summary><h3>PHP Information</h3></summary>
            <div id="infoPhp">

                <{foreach from=$phpInfo key="categoryName" item="info"}>
                <details>
                <summary><h3><{$categoryName|ucwords}></h3></summary>
                <div class="infoCat">
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
                </div>
                </details>
                <{/foreach}>

            </div>
            </details>
            <{*  phpInfo  *}>


        </div>
	    <{*  adelieDebugDetail  *}>

		</div>
        <{*  adelieDebug  *}>

	</div>
	<{*  adelie_view  *}>

    <div id="kint_view">
        <h1>Kint</h1>
        <{if file_exists("Kint.class.php")}>
            <{include file="Kint.class.php"}>
        <{else}>
        <p>Kint is not installed!</p>
        <{/if}>
    </div>

    <div id="dialogAbout" title="About AdelieDebug">
        <h4>AdelieDebug</h4>
        <{if $isBuild}>
        <span class="adelieVersion">Build <{'YmdHis'|date:$buildTime}></span>
        <{else}>
        <span class="adelieVersion">Source</span>
        <{/if}>

        <h4>Credits</h4>

        <div class="adelieAuthor">Author Suin<br>
        Update by Naon-pon (PHP7)<br>
        Update by Gigamaster (XCL23)</div>

        <h4>Cheat Sheet</h4>

        <div class="adelieDebugHelp">
            <span>adump([mixed[, mixed]])</span>
            <span>atrace()</span>
            <span>awhich(object|string)</span>
            <span>asynop(object|string)</span>
            <{*<span class="adelieDebugHelpMore"><a href="<{$xoops_url}>/index.php/debug/help/">more…</a></span>*}>
        </div>
        <{*  adelieDebugHelp  *}>

    </div>


</div>
<{*  xhelper-main  *}>


