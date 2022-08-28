using Microsoft.AspNetCore.Builder;

namespace Web.Interceptors.RequestInterceptor
{
    /// <summary>
    /// ExceptionMiddleware Extensions
    /// </summary>
    public static class RequestInterceptorExtensions
    {
        /// <summary>
        /// Define ConfigureCustomExceptionMiddleware extention on IApplicationBuilder
        /// </summary>
        /// <param name="app"></param>
        public static void ConfigureCustomExceptionMiddleware(this IApplicationBuilder app)
        {
            app.UseMiddleware<RequestInterceptorMiddleware>();
        }
    }
}
