<script type="text/javascript">
    if (typeof jQuery == 'undefined') {
        // Fallback for CDN in case of Fatal error!
    document.write(unescape("%3Cscript src='https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
}
</script>
<style><{$css}></style>


<{* Capture Result and Total of Errors to show in the menu *}>
<{capture name="adeResult"}>
<{foreach from=$errorSummary key="typeName" item="ids"}>
    <div class="msgError">
        <strong><{$typeName}> [ <{capture name="adeError"}><{$ids|@count}><{/capture}><{$smarty.capture.adeError}> ]</strong>
        <span>...</span>
        <{foreach from=$ids item="id"}>
        <a href="#adelieDebugLogId<{$id}>" class="errorId">#<{$id}></a>
        <{/foreach}>
    </div>
    <{foreachelse}>
    <div class="msgSuccess">There is no error.</div>
    <{/foreach}>
<{/capture}>


<div id="xhelp-main">

    <div id="xhelp-menu">
        <a href="#adelie">AdelieDebug <{if $smarty.capture.adeError ne ""}><span><{$smarty.capture.adeError}></span><{/if}></a>
        <a href="#kint">Kint</a>
    </div>


    <div id="adelie_view">

        <div id="viewTitle">

            <div class="title">
            <a href="#xhelp-about" aria-label="About AdelieDebug">ℹ — AdelieDebug</a> — <small> <{if $isAdmin}>Admin<{else}>Safe<{/if}> mode</small>
            </div>

            <div id="viewControl">
                <a href="#" id="maximize" aria-label="maximize">🗖</a>
                <a href="#" id="minimize" aria-label="minimize">🗕</a>
                <a href="#adelie" id="close-view" title="Close">🗙</a>
            </div>

        </div>
        <{* viewTitle *}>

        <div class="adelieDebug" id="adelieReport">

		<h3>Report</h3>

            <{$smarty.capture.adeResult}>


		<div id="adelieDebugDetail">

           <details class="timeline">
           <summary><h3>Timeline</h3></summary>

            <div id="adelieDebugPhpErrors">
            <table class="data">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>ms</th>
                    <th>Type</th>
                    <th>Message</th>
                </tr>
            </thead>
            <tbody>
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
                                <div style="width: <{$log.timePer}>%;" class="logTime"></div>
                                <div style="position: relative;"><{$message|escape}></div>
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
            </tbody>
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
                            <thead>
                                <tr>
                                    <th>Key</th>
                                    <th>Value</th>
                                </tr>
                            </thead>
                            <tbody>
                            <{foreach from=$request key="key" item="value"}>
                                    <tr>
                                        <td><{$key}></td>
                                        <td><{$value|@var_dump}></td>
                                    </tr>
                                <{/foreach}>
                            </tbody>
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
                    <thead>
                        <tr>
                            <th>Key</th>
                            <th>Value</th>
                        </tr>
                    </thead>
                    <tbody>
                        <{foreach from=$info key="key" item="value"}>
                        <tr>
                            <td><{$key}></td>
                            <td><{$value}></td>
                        </tr>
                        <{/foreach}>
                    </tbody>
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
	    <{* adelieDebugDetail  *}>

		</div>
        <{*  adelieDebug  *}>


	</div>
	<{*  adelie_view  *}>

    <div id="kint_view">
        <div class="kintDebug">
        <h1>Kint</h1>
        <{if file_exists("Kint.class.php")}>
            <{include file="Kint.class.php"}>
        <{else}>
        <div class="error">Kint is not installed!</div>
        <{/if}>
        </div>
    </div>


    <div id="xhelp-about" class="xhelp-overlay" title="About AdelieDebug">
    <div class="xhelp-modal">

    <a class="xhelp-close" href="#">&times;</a>

        <div class="xhelp-content">

            <h2>Adelie<b>Debug</b></h2>

            <{if $isBuild}>
            <span class="data" title="AdelieDebug Version">Build <{'YmdHis'|date:$buildTime}></span>
            <{else}>
            <span class="data" title="adelieVersion">Source</span>
            <{/if}>

            <p>A powerful development tool for developers of XCL modules, preloads and themes — <a href="https://github.com/xoopscube/adelie-debug-xcl" target="_blank">License GPL v2.0</a></p>

            <h3>Credits</h3>

            <span class="data" title="AdelieDebug Authors">
            Author Suin &copy; 2011<br>
            Update by Naon-pon (PHP7)<br>
            Update by Gigamaster (XCL23)
            </span>

            <h3>Cheat Sheet</h3>

            <span class="data" title="AdelieDebug Help">
                adump([mixed[, mixed]])<br>
                atrace()<br>
                awhich(object|string)<br>
                asynop(object|string)
                <{*<span class="adelieDebugHelp"><a href="<{$xoops_url}>/index.php/debug/help/">more…</a></span>*}>
            </div>
            <{*  adelieDebugHelp  *}>

            </div><{* xhelp-content *}>

        </div><{* xhelp-content *}>
    </div><{* xhelp-modal *}>


</div>
<{*  xhelp-main  *}>

<script><{$js}></script>
