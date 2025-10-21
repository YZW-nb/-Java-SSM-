<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的申请记录 - 社团管理系统</title>
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
                <a href="${pageContext.request.contextPath}/student/home" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-home w-5 text-center"></i>
                    <span>首页</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/member/my" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-university w-5 text-center"></i>
                    <span>我的社团</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/activity/my" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-calendar w-5 text-center"></i>
                    <span>我的活动</span>
                </a>
                <a href="${pageContext.request.contextPath}/fund/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-credit-card w-5 text-center"></i>
                    <span>经费申请</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/apply/my" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
                    <i class="fa fa-file-text w-5 text-center"></i>
                    <span>我的申请</span>
                </a>
                <a href="${pageContext.request.contextPath}/user/setting" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-cog w-5 text-center"></i>
                    <span>个人设置</span>
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
                        <input type="text" placeholder="搜索申请记录..." class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary w-64">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">我的申请记录</h2>
                <p class="text-gray-600">查看你申请加入社团的历史记录和状态</p>
            </div>

            <!-- 提示消息区域 -->
            <c:if test="${not empty message}">
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6">
                    <i class="fa fa-check-circle mr-2"></i>${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
                    <i class="fa fa-exclamation-circle mr-2"></i>${error}
                </div>
            </c:if>

            <!-- 申请记录表格 -->
            <div class="bg-white rounded-xl overflow-hidden card-shadow">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                申请ID
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                社团名称
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                申请时间
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                状态
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                审核时间
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                操作
                            </th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${myApplies}" var="apply">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        ${apply.id}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        ${apply.club.name} <!-- 假设Club对象已通过关联查询获取 -->
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        ${apply.applyTime}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${apply.status == 'pending'}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                                    待审核
                                                </span>
                                        </c:when>
                                        <c:when test="${apply.status == 'approved'}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                    已通过
                                                </span>
                                        </c:when>
                                        <c:when test="${apply.status == 'rejected'}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                                    已拒绝
                                                </span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        ${apply.reviewTime != null ? apply.reviewTime : '未审核'}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <c:if test="${apply.status == 'pending'}">
                                        <button class="text-red-600 hover:text-red-900">
                                            取消申请
                                        </button>
                                    </c:if>
                                    <button class="text-primary-600 hover:text-primary-900 ml-2">
                                        查看详情
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- 分页控件 -->
                <div class="px-6 py-4 border-t border-gray-200 bg-gray-50">
                    <div class="flex items-center justify-between">
                        <div class="flex-1 flex justify-between sm:hidden">
                            <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                上一页
                            </a>
                            <a href="#" class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                下一页
                            </a>
                        </div>
                        <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                            <div>
                                <p class="text-sm text-gray-700">
                                    显示第 <span class="font-medium">1</span> 到 <span class="font-medium">5</span> 条，共 <span class="font-medium">12</span> 条记录
                                </p>
                            </div>
                            <div>
                                <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                    <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                        <span class="sr-only">上一页</span>
                                        <i class="fa fa-chevron-left"></i>
                                    </a>
                                    <a href="#" aria-current="page" class="z-10 bg-primary text-white relative inline-flex items-center px-4 py-2 border border-primary text-sm font-medium">
                                        1
                                    </a>
                                    <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                        2
                                    </a>
                                    <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                        3
                                    </a>
                                    <span class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700">
                                        ...
                                    </span>
                                    <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                        12
                                    </a>
                                    <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                        <span class="sr-only">下一页</span>
                                        <i class="fa fa-chevron-right"></i>
                                    </a>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- 侧边栏切换脚本 -->
<script>
    // 侧边栏切换
    document.getElementById('toggle-sidebar').addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('-translate-x-full');
    });

    document.getElementById('mobile-menu-button').addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('-translate-x-full');
    });

    window.addEventListener('resize', function() {
        const sidebar = document.getElementById('sidebar');
        if (window.innerWidth >= 1024) {
            sidebar.classList.remove('-translate-x-full');
        }
    });
</script>
</body>
</html>