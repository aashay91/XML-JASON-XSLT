package conversion;

import java.io.IOException;
import java.util.logging.Logger;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

/**
 * It uses <tt>XmlPatientToJasonPatient.xsl</tt> XSLT file to convert xml file into jason text.
 *
 */
public class XmlToJason
{
   private final static Logger LOG = Logger.getLogger(XmlToJason.class.getName());
   private final TransformerFactory factory = TransformerFactory.newInstance();
   private final StreamSource xsltStream;
   private final StreamSource inputFileStream;
   private final StreamResult outputStream;

   public XmlToJason(StreamSource xsltStream, StreamSource inputFileStream, StreamResult outputStream)
   {
      this.xsltStream = xsltStream;
      this.inputFileStream = inputFileStream;
      this.outputStream = outputStream;
   }

   public void convert() throws IOException
   {
      LOG.info("entering convert");
      try
      {
         Transformer transformer = factory.newTransformer(xsltStream);
         transformer.transform(inputFileStream, outputStream);
      }
      catch (TransformerException e)
      {
         e.printStackTrace();
      }
      LOG.info("leaving convert please check jason output file in main resources.");
   }
}
