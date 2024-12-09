<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">
  <xsl:output method="text"/>
<?startSampleFile ?>
<!-- xq430.xsl: converts xq423.xml into xq431.xml -->

<xsl:template match="employees">
  <xsl:apply-templates>
    <xsl:sort select="last"/>
    <xsl:sort select="first"/>
  </xsl:apply-templates>
</xsl:template>
<?endSampleFile ?>

<xsl:template match="employee">
  Last:      <xsl:apply-templates select="last"/>
  First:     <xsl:apply-templates select="first"/>
  Salary:    <xsl:apply-templates select="salary"/>
  Hire Date: <xsl:apply-templates select="@hireDate"/>
  <xsl:text>
</xsl:text>

</xsl:template>

</xsl:stylesheet>


