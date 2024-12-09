<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">
  <xsl:output method="text"/>
<?startSampleFile ?>
<!-- xq428.xsl: converts xq423.xml into xq429.xml -->

<xsl:template match="employees">
  <xsl:apply-templates>
    <xsl:sort select="salary" data-type="number" order="descending"/>
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


