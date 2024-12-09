<?startSampleFile ?>
<!-- xq439.xsl: converts xq436.xml into xq440.txt -->
<!DOCTYPE stylesheet [
<!ENTITY space "<xsl:text> </xsl:text>">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">
  <xsl:output method="xml" omit-xml-declaration="yes" indent="no"/>

  <xsl:template match="wine">
	 <xsl:apply-templates select="winery"/>&space;
	 <xsl:apply-templates select="product"/>&space;
	 <xsl:apply-templates select="year"/>&space;
	 <xsl:apply-templates select="@grape"/>
	 <xsl:if test="@grape = 'Chardonnay'">
		<xsl:text>
  other Chardonnays:
</xsl:text>
		<xsl:for-each 
		  select="preceding-sibling::wine[@grape = 'Chardonnay'] |
                     following-sibling::wine[@grape = 'Chardonnay']">
			<xsl:sort select="winery"/>
			<xsl:text>    </xsl:text>
			<xsl:value-of select="winery"/>&space;
			<xsl:value-of select="product"/><xsl:text>
</xsl:text>
		</xsl:for-each>
    </xsl:if>
</xsl:template>

<?endSampleFile ?>
</xsl:stylesheet>
