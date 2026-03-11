using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using System.Net;

class Program
{
    public class Page
    {
        public string Url;
        
        public Page(string url)
        {
            Url = url;
        }
                
        public async Task<String> GetHtmlCode()
        {
            String html = "";
            using (WebClient client = new WebClient())
            {
                try
                {
                    html = await client.DownloadStringTaskAsync(Url);
                }
                catch (Exception ex)
                {
                    Console.Write("(!) Exception on {0} - {1}", Url, ex.Message);
                    Console.WriteLine();
                }                
            }
            return html;
        }
    }

      
    public class Parser
    {
        public async Task<Page[]> GetLinks(Page[] pages, int depth)
        {
            while (depth != 0)
            {
                foreach (var page in pages)
                {
                    var internalPages = await ParseHtmlPageAsync(page);
                    pages = pages.Concat(internalPages).ToArray();
                }
                
                depth--;
            }
    
            return pages;
        }
        
        private async Task<Page[]> ParseHtmlPageAsync(Page p)
        {
            var pattern = new Regex(@"<a.*? href=""(?<url>https?[\w\.:?&-_=#/]*)""+?"); // <a href="http://...">
            var html = await p.GetHtmlCode();
            
            var links = pattern.Matches(html);

            var pages = new Page[links.Count];
            for (var i = 0; i < links.Count; i++)
            {
                pages[i] = new Page(links[i].Groups["url"].Value);
            }
            return pages;
        }
    }
      
    public static void Main(string[] args)
    {
        var link = "https://github.com/";
        var parser = new Parser();
            
        var pages = parser.GetLinks(new[] {new Page(link)} , 2).Result;
            
        foreach (var page in pages)
        {
            Console.WriteLine("Link: {0} - {1} symbols", page.Url, page.GetHtmlCode().Result.Length);
        }
    }
}