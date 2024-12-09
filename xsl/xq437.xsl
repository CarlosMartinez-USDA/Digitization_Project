<?startSampleFile ?>
<!-- xq437.xsl: converts xq436.xml into xq438.xml -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">

  <xsl:template match="winelist">
    <xsl:copy>
      <xsl:apply-templates>
         <xsl:sort  data-type="number" select="prices/discounted"/>
         </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
<?endSampleFile ?>
