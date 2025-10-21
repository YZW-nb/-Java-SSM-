<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>经费详情 - 社团管理系统</title>
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
                <a href="${pageContext.request.contextPath}/activity/my" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-calendar w-5 text-center"></i>
                    <span>活动列表</span>
                </a>
                <a href="${pageContext.request.contextPath}/fund/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
                    <i class="fa fa-credit-card w-5 text-center"></i>
                    <span>经费申请</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/apply/toApplyPage" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">经费详情</h2>
                <p class="text-gray-600">ID: ${fund.id}</p>
            </div>

            <!-- 经费详情卡片 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-500 mb-1">社团</h3>
                            <p class="text-lg font-semibold text-gray-900">${clubName}</p>
                        </div>
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-500 mb-1">经费类型</h3>
                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${fund.type == 1 ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                ${fund.type == 1 ? '收入' : '支出'}
                            </span>
                        </div>
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-500 mb-1">金额</h3>
                            <p class="text-2xl font-bold ${fund.type == 1 ? 'text-green-600' : 'text-red-600'}">
                                ${fund.type == 1 ? '+' : '-'}¥<fmt:formatNumber value="${fund.amount}" pattern="#,##0.00" />
                            </p>
                        </div>
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-500 mb-1">日期</h3>
                            <p class="text-gray-900"><fmt:formatDate value="${fund.fundDate}" pattern="yyyy-MM-dd" /></p>
                        </div>
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-500 mb-1">操作人</h3>
                            <p class="text-gray-900">${operatorName}</p>
                        </div>
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-500 mb-1">记录时间</h3>
                            <p class="text-gray-900"><fmt:formatDate value="${fund.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
                        </div>
                    </div>
                    <div>
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-500 mb-1">来源/用途</h3>
                            <p class="text-gray-900 whitespace-pre-line">${fund.sourceOrPurpose}</p>
                        </div>
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-500 mb-1">备注</h3>
                            <p class="text-gray-900 whitespace-pre-line">${fund.remark}</p>
                        </div>
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-500 mb-1">凭证</h3>
                            <c:if test="${not empty fund.proofDesc}">
                                <div class="mt-2">
                                    <div class="flex items-center p-3 bg-gray-50 rounded-lg border border-gray-200">
                                        <i class="fa fa-file-pdf-o text-2xl text-red-500 mr-3"></i>
                                        <div class="flex-1 min-w-0">
                                            <a href="${pageContext.request.contextPath}/fund/download/${fund.id}" class="text-sm font-medium text-primary truncate">${fund.proofDesc}</a>
                                            <p class="text-xs text-gray-500 truncate">
                                                <fmt:formatNumber value="${fund.proofSize/1024}" pattern="#,##0.0" /> KB
                                            </p>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/fund/download/${fund.id}" class="ml-4 text-gray-500 hover:text-gray-700">
                                            <i class="fa fa-download"></i>
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${empty fund.proofDesc}">
                                <p class="text-gray-500">未上传凭证</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="flex justify-end space-x-3">
                <a href="${pageContext.request.contextPath}/fund/list" class="px-4 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors">
                    返回
                </a>

                <c:if test="${fund.type == 2}">
                    <a href="${pageContext.request.contextPath}/fund/update/amount/${fund.id}" class="px-4 py-2 bg-accent text-white rounded-lg text-sm font-medium hover:bg-accent/90 transition-colors">
                        <i class="fa fa-pencil mr-1"></i> 修改金额
                    </a>
                </c:if>
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