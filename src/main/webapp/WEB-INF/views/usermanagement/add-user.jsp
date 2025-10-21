<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加用户 - 社团管理系统</title>
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
                <a href="${pageContext.request.contextPath}/admin/home" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-home w-5 text-center"></i>
                    <span>首页</span>
                </a>



                <a href="${pageContext.request.contextPath}/admin/users/user/add" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
                    <i class="fa fa-user-plus w-5 text-center"></i>
                    <span>添加用户</span>
                </a>

                <a href="${pageContext.request.contextPath}/club/manage" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-university w-5 text-center"></i>
                    <span>社团管理</span>
                </a>
                <a href="${pageContext.request.contextPath}/activitysignup/signup/list/all" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-calendar w-5 text-center"></i>
                    <span>活动审批</span>
                </a>
                <a href="${pageContext.request.contextPath}/fund/management" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">添加普通用户</h2>
                <p class="text-gray-600">在此添加新的系统用户</p>
            </div>

            <!-- 消息提示 -->
            <c:if test="${not empty error}">
                <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6 rounded-r" role="alert">
                    <div class="flex">
                        <div class="py-1"><i class="fa fa-exclamation-circle text-red-500 mr-3"></i></div>
                        <div>
                            <p class="font-bold">错误</p>
                            <p>${error}</p>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- 添加用户表单 -->
            <div class="bg-white rounded-xl p-6 card-shadow max-w-2xl mx-auto">
                <div class="mb-6">
                    <h3 class="text-xl font-bold text-gray-800">用户信息</h3>
                    <p class="text-gray-600">填写以下信息创建新用户</p>
                </div>

                <form method="post" action="${pageContext.request.contextPath}/admin/users/user/add">
                    <div class="space-y-5">
                        <div class="grid grid-cols-1 gap-4">
                            <div>
                                <label for="username" class="block text-sm font-medium text-gray-700 mb-1">用户名</label>
                                <input type="text" id="username" name="username" required
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-primary transition-colors">
                            </div>

                            <div>
                                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">密码</label>
                                <input type="password" id="password" name="password" required
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-primary transition-colors">
                            </div>

                            <div>
                                <label for="name" class="block text-sm font-medium text-gray-700 mb-1">姓名</label>
                                <input type="text" id="name" name="name" required
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-primary transition-colors">
                            </div>

                            <div>
                                <label for="studentId" class="block text-sm font-medium text-gray-700 mb-1">学号</label>
                                <input type="text" id="studentId" name="studentId" required
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-primary transition-colors">
                            </div>
                        </div>
                    </div>

                    <div class="flex justify-end mt-6 space-x-3">
                        <a href="${pageContext.request.contextPath}/admin/users/user/list"
                           class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 transition-colors">
                            返回
                        </a>
                        <button type="submit"
                                class="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors shadow-sm">
                            <i class="fa fa-check mr-2"></i> 提交
                        </button>
                    </div>
                </form>
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
