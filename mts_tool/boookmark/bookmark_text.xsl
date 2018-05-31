<?xml version="1.0" encoding="Shift_JIS"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="text" encoding="Shift_JIS" />

<!--
■NOTE
<xsl:text>
</xsl:text>
は改行を出力するために必要
-->

<!-- bookmarkを処理 -->
<xsl:template match="bookmark">
  <xsl:apply-templates select="//category"/>
</xsl:template>

<!-- categoryを処理 -->
<xsl:template match="category">

<xsl:text>-----------------------------------
</xsl:text>
  <xsl:value-of select="@name"/><xsl:text>
</xsl:text>
<xsl:text>-----------------------------------
</xsl:text>
    <xsl:apply-templates select="item"/><xsl:text/>
</xsl:template>


<!-- category配下のitemを処理 -->
<xsl:template match="item">
<xsl:value-of select="title" /><xsl:text>
</xsl:text>
<xsl:value-of select="path" /><xsl:text>
</xsl:text>
<xsl:value-of select="id" /><xsl:text>
</xsl:text>
<xsl:value-of select="pass" /><xsl:text>

</xsl:text>
</xsl:template>

</xsl:stylesheet>
 
 