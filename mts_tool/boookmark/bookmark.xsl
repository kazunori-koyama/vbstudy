<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">

<html>
<title>bookmark</title>
<head>
<meta charset="UTF-8" />

<script type="text/javascript" src="./jquery-1.10.2.js"></script>
<script type="text/javascript" src="./jquery.cookie.js"></script>
<script type="text/javascript">
$(function(){
    
    //
    // リンククリック時
    //
    //$('.pathlink').dblclick(function(){
    //    new ActiveXObject("WScript.Shell").Run($(this).text().trim());
    //});
    
    //
    // ID、パスワード選択時
    //
    $('.readonly-text').focus(function(){
        $(this).select();
    });
    
    //
    // テーブル要素のtr要素をマウスオーバーしたら
    // 
    $('.bookmark-item').hover(
        function(){
            // hoverクラス「hv」を追加する
            $(this).addClass('hv');
        },
        // マウスアウトしたら
        function(){
            $(this).removeClass('hv');
        }
    );

    //
    // tabをクリックした場合
    //
    $('.tab-item').click(function(){
        activateTab($(this).text());
        $.cookie('active-tab', $(this).text(), { expires: 30 });
    });

    //
    // categoryをクリックした場合
    //
    $('.category').click(function(){
        $(this).next('table').toggle();
        $.cookie($(this).text(), $(this).next('table').css('display'), { expires: 30 });
    });
    

    var activateTab = function(tabname) {
        $('span[tabname]').removeClass('select');
        $('span[tabname=' + tabname + ']').addClass('select');
        $('div[tabname]').css('display', 'none');
        $('div[tabname=' + tabname + ']').toggle();
    };
    
    //
    // *** 以下はOnload時に実行する関数 ***
    //
    
    //
    // cookieから開閉状態を復元します。
    //
    (function(){
        // tab
        activateTab($.cookie('active-tab'));

        $('div[class=category]').each(function(){
            // category
            $(this).next('table').css('display', $.cookie($(this).text()));
        });
    })();

});

</script>

<style type="text/css">
body,form,input,textarea {
    font:100%/1.4 "メイリオ"; 
    font-size:10pt; color:#376092; 
}

table {
    table-layout: fixed;
}

table.Grid {
    font-size:10pt;
    border-collapse :collapse;
    width:100%;
} 

table.Grid th { 
    text-align: center;
    height: 30px;
    border: solid 1px #DCE6F2;
    font-weight: bold; 
    color: #DCE6F2; 
    background-color: #538DD5;
}

table.Grid td {
    border: solid 1px #538DD5;
    background-color: #ffffff;
    word-break:break-all;
}

.pathlink {
    cursor : pointer;
}

.readonly-text {
    border: none;
    padding : 0px;
    mergin : 0px;
    width : 98%;
}

table.Grid tr.hv input {
    background-color: #fff0f8;
}

table.Grid tr.hv td {
    background-color: #fff0f8;
}

.category {
    background-color: #dafacf !important;
    font-weight: bold; 
    border-left: solid 1px #538DD5;
    border-right: solid 1px #538DD5;
    border-bottom: solid 1px #538DD5;
    cursor : pointer;
    vartical-align : center;
}

.tab {
    cursor : pointer;
}

.tab span {
    background:#C6D9F1;
    padding:5px 25px;
    float:left;
    margin: 0px 2px;
    border: 1px solid #376092;
    
    /* 角丸 */
    border-radius: 13px 13px 0 0;
    -webkit-border-radius: 13px 13px 0 0;
    -moz-border-radius: 13px 13px 0 0;
}

.tab span.select {
    background:#f9f9f9;
    border: 1px solid #538DD5;
}


</style>

</head>

<body>


<div style="width:98%">

<!-- tabを作成 -->
<xsl:call-template name="tab-create" />

<table class="Grid">
<tr>
<th style="width:20%">タイトル</th>
<th>パス</th>
<th style="width:15%">ID</th>
<th style="width:15%">PassWord</th>
</tr>
</table>

<!-- listを作成 -->
<xsl:call-template name="list-create" />

</div>
</body>
</html>

</xsl:template>


<!-- tabを作成1 -->
<xsl:template name="tab-create">
  <div class="tab" style="border-bottom:1px">
    <xsl:apply-templates select="//group"/>
  </div>
</xsl:template>

<!-- tabを作成2 -->
<xsl:template match="group">
  <span class="tab-item">
    <xsl:attribute name="tabname"><xsl:value-of select="@name" /></xsl:attribute>
    <xsl:value-of select="@name"/>
  </span>
</xsl:template>


<!-- listを生成 -->
<xsl:template name="list-create">
  <xsl:apply-templates select="//group" mode="list-group" />
</xsl:template>

<xsl:template match="group" mode="list-group">
  <div>
    <xsl:attribute name="tabname"><xsl:value-of select="@name" /></xsl:attribute>
    <xsl:apply-templates select="category"/>
  </div>
</xsl:template>

<!-- categoryを処理 -->
<xsl:template match="category">
  <div class="category">
    <xsl:value-of select="@name"/>
  </div>
  <table class="Grid">
    <xsl:apply-templates select="item"/>
  </table>
</xsl:template>

<!-- category配下のitemを処理 -->
<xsl:template match="item">
  <tr class="bookmark-item">
    
    <td style="width:20%;border-top: none;"><xsl:value-of select="title" /></td>
    
    <td class="pathlink" style="border-top: none;">
        <a type="text" >
            <xsl:attribute name="href"><xsl:value-of select="path" /></xsl:attribute>
            <xsl:attribute name="target">_blank</xsl:attribute>
            <xsl:value-of select="path" />
        </a>
    </td>

    <td style="width:15%;border-top: none;">
       <input type="text" class="readonly-text">
         <xsl:attribute name="value"><xsl:value-of select="id" /></xsl:attribute>
       </input>
    </td>

    <td style="width:15%;border-top: none;">
       <input type="text" class="readonly-text">
         <xsl:attribute name="value"><xsl:value-of select="pass" /></xsl:attribute>
       </input>
    </td>
    
  </tr>
</xsl:template>

</xsl:stylesheet>
 
 