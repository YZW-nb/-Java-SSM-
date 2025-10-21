<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>经费管理 - 社团管理系统</title>
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
                <i class="fa fa-shield text-primary text-2xl"></i>
                <h1 class="text-xl font-bold text-gray-800">社团管理系统</h1>
            </div>
            <button id="toggle-sidebar" class="lg:hidden text-gray-500 hover:text-primary">
                <i class="fa fa-bars"></i>
            </button>
        </div>

        <div class="p-4">
            <div class="flex items-center space-x-3 mb-6">
                <img src="https://picsum.photos/id/177/40/40" alt="管理员头像" class="w-10 h-10 rounded-full object-cover border-2 border-primary">
                <div>
                    <p class="font-medium text-gray-800">李四</p>
                    <p class="text-xs text-gray-500">学生处管理员</p>
                </div>
            </div>

            <nav class="space-y-1">
                <a href="${pageContext.request.contextPath}/admin/home"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg
                   ${fn:contains(pageContext.request.requestURI, '/admin/home') ? 'nav-active' : 'hover:bg-gray-100 transition-colors'}">
                    <i class="fa fa-home w-5 text-center"></i>
                    <span>首页</span>
                </a>

                <a href="${pageContext.request.contextPath}/club/manage"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg
                   ${fn:contains(pageContext.request.requestURI, '/club/manage') ? 'nav-active' : 'hover:bg-gray-100 transition-colors'}">
                    <i class="fa fa-university w-5 text-center"></i>
                    <span>社团管理</span>
                </a>

                <a href="${pageContext.request.contextPath}/activitysignup/signup/list/all"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg
                   ${fn:contains(pageContext.request.requestURI, '/activitysignup/signup/list/all') ? 'nav-active' : 'hover:bg-gray-100 transition-colors'}">
                    <i class="fa fa-calendar w-5 text-center"></i>
                    <span>活动审批</span>
                </a>

                <a href="${pageContext.request.contextPath}/fund/management"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg
                   ${fn:contains(pageContext.request.requestURI, '/fund/management') ? 'nav-active' : 'hover:bg-gray-100 transition-colors'}">
                    <i class="fa fa-credit-card w-5 text-center"></i>
                    <span>经费管理</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/users/user/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-users w-5 text-center"></i>
                    <span>用户管理</span>
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
                        <input type="text" placeholder="搜索..." class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary w-64">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">经费管理</h2>
                <p class="text-gray-600">管理收入和支出</p>
            </div>

            <!-- 经费统计卡片 -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">总收入</h3>
                        <div class="w-10 h-10 rounded-full bg-green-100 flex items-center justify-center">
                            <i class="fa fa-arrow-down text-green-600"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">¥25,800.00</span>
                        <span class="text-green-500 text-sm flex items-center">
                            <i class="fa fa-arrow-up mr-1"></i> 12%
                        </span>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">总支出</h3>
                        <div class="w-10 h-10 rounded-full bg-red-100 flex items-center justify-center">
                            <i class="fa fa-arrow-up text-red-600"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">¥18,300.00</span>
                        <span class="text-red-500 text-sm flex items-center">
                            <i class="fa fa-arrow-up mr-1"></i> 8%
                        </span>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">当前余额</h3>
                        <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center">
                            <i class="fa fa-balance-scale text-primary"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">¥7,500.00</span>
                        <span class="text-green-500 text-sm flex items-center">
                            <i class="fa fa-arrow-up mr-1"></i> 4%
                        </span>
                    </div>
                </div>
            </div>

            <!-- 搜索筛选区 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">筛选条件</h3>
                <form action="${pageContext.request.contextPath}/fund/management" method="get" class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">社团</label>
                        <select name="clubId" class="w-full border border-gray-300 p-2 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                            <option value="">所有社团</option>
                            <c:forEach items="${clubs}" var="club">
                                <option value="${club.id}">${club.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">开始日期</label>
                        <input type="date" name="startTime" class="w-full border border-gray-300 p-2 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">结束日期</label>
                        <input type="date" name="endTime" class="w-full border border-gray-300 p-2 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">类型</label>
                        <select name="type" class="w-full border border-gray-300 p-2 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                            <option value="">所有类型</option>
                            <option value="1">收入</option>
                            <option value="2">支出</option>
                        </select>
                    </div>
                    <div class="md:col-span-4 flex justify-end">
                        <button type="submit" class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg flex items-center">
                            <i class="fa fa-search mr-2"></i>搜索
                        </button>
                    </div>
                </form>
            </div>

            <!-- 经费列表 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">经费记录</h3>
                    <a href="${pageContext.request.contextPath}/fund/fund/add" class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg flex items-center">
                        <i class="fa fa-plus mr-2"></i>添加经费
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">所属社团</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">类型</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">金额</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">来源/用途</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">操作人</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">凭证说明</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">记录时间</th>
                            <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${funds}" var="fund">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${fund.id}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">
                                        <c:forEach items="${clubs}" var="club">
                                            <c:if test="${club.id == fund.clubId}">
                                                ${club.name}
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${fund.type == 1}">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                收入
                                            </span>
                                        </c:when>
                                        <c:when test="${fund.type == 2}">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                                支出
                                            </span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">
                                        <c:choose>
                                            <c:when test="${fund.type == 1}">+¥${fund.amount}</c:when>
                                            <c:when test="${fund.type == 2}">-¥${fund.amount}</c:when>
                                        </c:choose>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="text-sm text-gray-900">${fund.sourceOrPurpose}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">操作人ID: ${fund.operatorId}</div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="text-sm text-gray-900">${fund.proofDesc}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-500">${fund.createTime}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                    <a href="${pageContext.request.contextPath}/fund/admin/update/amount/${fund.id}" class="text-primary hover:text-primary/80 mr-3">修改金额</a>
                                    <a href="${pageContext.request.contextPath}/fund/admin/delete/${fund.id}" class="text-red-500 hover:text-red-800" onclick="return confirm('确定要删除这条记录吗？')">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- 分页控件 -->
                <div class="flex items-center justify-between pt-4">
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
                                显示第 <span class="font-medium">1</span> 到 <span class="font-medium">10</span> 条，共 <span class="font-medium">25</span> 条记录
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
                                    5
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

    // 导航高亮逻辑
    document.addEventListener('DOMContentLoaded', function() {
        const currentPath = window.location.pathname;
        document.querySelectorAll('aside nav a').forEach(link => {
            const href = link.getAttribute('href');
            if (href && currentPath.startsWith(href)) {
                link.classList.add('nav-active');
            } else {
                link.classList.remove('nav-active');
            }
        });
    });
</script>
</body>
</html>