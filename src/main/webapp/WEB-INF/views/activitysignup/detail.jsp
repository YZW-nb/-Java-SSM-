<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalDateTime" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>报名成功 - 社团管理系统</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3B82F6',
                        secondary: '#10B981',
                        accent: '#8B5CF6',
                        neutral: '#64748B',
                        'base-100': '#F8FAFC',
                    },
                    fontFamily: {
                        sans: ['Inter', 'system-ui', 'sans-serif'],
                    },
                }
            }
        }
    </script>
    <style type="text/tailwindcss">
        @layer utilities {
            .content-auto {
                content-visibility: auto;
            }
            .card-shadow {
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            }
            .nav-active {
                @apply bg-primary/10 text-primary border-l-4 border-primary;
            }
        }
    </style>
</head>
<body class="bg-base-100 font-sans">
<div class="flex h-screen overflow-hidden">
    <!-- 侧边栏 -->
    <aside id="sidebar" class="w-64 bg-white shadow-lg transition-all duration-300 ease-in-out transform-gpu z-20">
        <div class="flex items-center justify-between p-4 border-b">
            <div class="flex items-center space-x-2">
                <i class="fa fa-users text-primary text-2xl"></i>
                <h1 class="text-xl font-bold text-gray-800">社团管理系统</h1>
            </div>
            <button id="toggle-sidebar" class="lg:hidden text-gray-500 hover:text-primary">
                <i class="fa fa-bars"></i>
            </button>
        </div>

        <div class="p-4">
            <div class="flex items-center space-x-3 mb-6">
                <img src="https://picsum.photos/id/64/40/40" alt="用户头像" class="w-10 h-10 rounded-full object-cover border-2 border-primary">
                <div>
                    <p class="font-medium text-gray-800">张三</p>
                    <p class="text-xs text-gray-500">信息学院</p>
                </div>
            </div>

            <nav class="space-y-1">
                <a href="${pageContext.request.contextPath}/student/me" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-home w-5 text-center"></i>
                    <span>首页</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/member/my"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-university w-5 text-center"></i>
                    <span>我的社团</span>
                </a>
                <a href="${pageContext.request.contextPath}/activity/my" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
                    <i class="fa fa-calendar w-5 text-center"></i>
                    <span>活动列表</span>
                </a>

                <a href="${pageContext.request.contextPath}/fund/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-credit-card w-5 text-center"></i>
                    <span>经费申请</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/apply/toApplyPage"    class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-file-text w-5 text-center"></i>
                    <span>社团申请</span>
                </a>
            </nav>
        </div>

        <div class="absolute bottom-0 w-full p-4 border-t">
            <a href="${pageContext.request.contextPath}/" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                <i class="fa fa-sign-out w-5 text-center text-red-500"></i>
                <span class="text-red-500">退出登录</span>
            </a>
        </div>
    </aside>

    <!-- 主内容区 -->
    <div class="flex-1 flex flex-col overflow-hidden">
        <!-- 顶部导航栏 -->
        <header class="bg-white shadow-sm z-10">
            <div class="flex items-center justify-between p-4">
                <div class="flex items-center lg:hidden">
                    <button id="mobile-menu-button" class="text-gray-500 hover:text-primary">
                        <i class="fa fa-bars text-xl"></i>
                    </button>
                </div>

                <div class="flex items-center space-x-4">
                    <div class="relative">
                        <input type="text" placeholder="搜索活动..." class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary w-64">
                        <i class="fa fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                    </div>

                    <div class="relative">
                        <button class="p-2 rounded-full hover:bg-gray-100 relative">
                            <i class="fa fa-bell-o text-gray-600"></i>
                            <span class="absolute top-0 right-0 w-2 h-2 bg-red-500 rounded-full"></span>
                        </button>
                    </div>

                    <div class="relative">
                        <button class="p-2 rounded-full hover:bg-gray-100 relative">
                            <i class="fa fa-envelope-o text-gray-600"></i>
                            <span class="absolute top-0 right-0 w-2 h-2 bg-blue-500 rounded-full"></span>
                        </button>
                    </div>
                </div>
            </div>
        </header>

        <!-- 内容滚动区域 -->
        <main class="flex-1 overflow-y-auto p-6 bg-gray-50">
            <div class="mb-6">
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">报名成功</h2>
                <p class="text-gray-600">您已成功报名参加 "${activity.title}"</p>
            </div>

            <!-- 成功提示卡片 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-6">
                <div class="flex items-start">
                    <div class="flex-shrink-0">
                        <div class="w-16 h-16 rounded-full bg-green-100 flex items-center justify-center">
                            <i class="fa fa-check-circle text-green-500 text-3xl"></i>
                        </div>
                    </div>
                    <div class="ml-4">
                        <h3 class="text-xl font-bold text-gray-800 mb-2">报名成功！</h3>
                        <p class="text-gray-600 mb-4">您已成功报名参加 "${activity.title}"。我们已记录您的报名信息，活动详情将通过系统通知您。</p>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-4">
                            <div class="flex items-start">
                                <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center mr-2 flex-shrink-0">
                                    <i class="fa fa-calendar text-primary text-sm"></i>
                                </div>
                                <div>
                                    <h4 class="font-medium text-gray-800 text-sm">活动时间</h4>
                                    <c:set var="localDateTime" value="${activity.startTime}" />
                                    <p class="text-gray-600 text-sm">${localDateTime}</p>
                                </div>
                            </div>
                            <div class="flex items-start">
                                <div class="w-8 h-8 rounded-full bg-green-100 flex items-center justify-center mr-2 flex-shrink-0">
                                    <i class="fa fa-map-marker text-secondary text-sm"></i>
                                </div>
                                <div>
                                    <h4 class="font-medium text-gray-800 text-sm">活动地点</h4>
                                    <p class="text-gray-600 text-sm">${activity.location}</p>
                                </div>
                            </div>
                            <div class="flex items-start">
                                <div class="w-8 h-8 rounded-full bg-purple-100 flex items-center justify-center mr-2 flex-shrink-0">
                                    <i class="fa fa-users text-accent text-sm"></i>
                                </div>
                                <div>
                                    <h4 class="font-medium text-gray-800 text-sm">主办方</h4>
                                    <c:choose>
                                        <c:when test="${activity.clubId == 1}">
                                            <p class="text-gray-600 text-sm">文化社团</p>
                                        </c:when>
                                        <c:when test="${activity.clubId == 2}">
                                            <p class="text-gray-600 text-sm">音乐社团</p>
                                        </c:when>
                                        <c:when test="${activity.clubId == 3}">
                                            <p class="text-gray-600 text-sm">体育社团</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-gray-600 text-sm">未知社团</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 操作按钮 -->
            <div class="flex flex-wrap gap-4">
                <a href="${pageContext.request.contextPath}/activity/my" class="bg-primary hover:bg-primary/90 text-white px-6 py-3 rounded-lg text-sm transition-colors flex items-center">
                    <i class="fa fa-calendar-check-o mr-2"></i> 查看我的活动
                </a>
                <a href="${pageContext.request.contextPath}/activity/list" class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-6 py-3 rounded-lg text-sm transition-colors flex items-center">
                    <i class="fa fa-th-list mr-2"></i> 浏览更多活动
                </a>
                <a href="${pageContext.request.contextPath}/student/home" class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-6 py-3 rounded-lg text-sm transition-colors flex items-center">
                    <i class="fa fa-home mr-2"></i> 返回首页
                </a>
            </div>
        </main>
    </div>
</div>

<script>
    // 侧边栏切换
    document.getElementById('toggle-sidebar').addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('-translate-x-full');
    });

    // 移动端菜单切换
    document.getElementById('mobile-menu-button').addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('-translate-x-full');
    });

    // 窗口大小变化时处理侧边栏显示
    window.addEventListener('resize', function() {
        const sidebar = document.getElementById('sidebar');
        if (window.innerWidth >= 1024) {
            sidebar.classList.remove('-translate-x-full');
        }
    });
</script>
</body>
</html>