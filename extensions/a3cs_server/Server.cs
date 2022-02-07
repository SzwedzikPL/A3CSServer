using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using RGiesecke.DllExport;
using System.Net.Http;
using System.Net;

namespace a3cs_server
{
    public class A3CSServerExtension
    {
        private static readonly HttpClient client = new HttpClient();
        private static readonly string URL = "";

        [DllExport("RVExtensionVersion", CallingConvention = CallingConvention.Winapi)]
        public static void RvExtensionVersion(StringBuilder output, int outputSize)
        {
            output.Append("A3CSServerExtension v1.0.0");
            return;
        }

        [DllExport("RVExtension", CallingConvention = CallingConvention.Winapi)]
        public static void RvExtension(StringBuilder output, int outputSize,
            [MarshalAs(UnmanagedType.LPStr)] string function)
        {
            output.Append(true);
            HTTPRequest(function);

            return;
        }

        [DllExport("RVExtensionArgs", CallingConvention = CallingConvention.Winapi)]
        public static int RvExtensionArgs(StringBuilder output, int outputSize,
            [MarshalAs(UnmanagedType.LPStr)] string function,
            [MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.LPStr, SizeParamIndex = 4)] string[] args, int argCount)
        {
            foreach (var arg in args)
            {
                output.Append(arg);
            }

            return 0;
        }

        private static async void HTTPRequest(string log)
        {
            try
            {
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

                Dictionary<string, string> values = new Dictionary<string, string>
                {
                    { "message", log }
                };

                FormUrlEncodedContent content = new FormUrlEncodedContent(values);
                _ = await client.PostAsync(URL, content);
            }
            catch
            {

            }

            return;
        }
    }
}