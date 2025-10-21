<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>申请加入社团 - 社团管理系统</title>
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
            .club-card-hover {
                @apply hover:shadow-lg hover:-translate-y-1 transition-all duration-300;
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
                <a href="${pageContext.request.contextPath}/fund/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-credit-card w-5 text-center"></i>
                    <span>经费申请</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/apply/toApplyPage" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
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
                        <input type="text" placeholder="搜索社团..." class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary w-64">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">申请加入社团</h2>
                <p class="text-gray-600">选择你感兴趣的社团，填写申请理由加入我们吧！</p>
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

            <!-- 社团分类筛选 -->
            <div class="bg-white rounded-xl p-4 card-shadow mb-6">
                <div class="flex flex-wrap gap-3">
                    <button class="px-4 py-2 bg-primary text-white rounded-full text-sm">全部社团</button>
                    <button class="px-4 py-2 bg-gray-100 hover:bg-gray-200 rounded-full text-sm transition-colors">学术科技</button>
                    <button class="px-4 py-2 bg-gray-100 hover:bg-gray-200 rounded-full text-sm transition-colors">文化体育</button>
                    <button class="px-4 py-2 bg-gray-100 hover:bg-gray-200 rounded-full text-sm transition-colors">志愿公益</button>
                    <button class="px-4 py-2 bg-gray-100 hover:bg-gray-200 rounded-full text-sm transition-colors">创新创业</button>
                </div>
            </div>

            <!-- 社团列表 -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                <c:forEach items="${clubList}" var="club">
                    <div class="bg-white rounded-xl overflow-hidden card-shadow club-card-hover">
                        <div class="h-48 relative">
                            <img src="https://picsum.photos/id/${club.id}/400/300" alt="${club.name}" class="w-full h-full object-cover">
                            <div class="absolute top-3 right-3 bg-primary/90 text-white text-xs px-2 py-1 rounded-full">
                                    ${club.category}
                            </div>
                        </div>

                        <div class="p-5">
                            <h3 class="text-lg font-bold text-gray-800 mb-2">${club.name}</h3>
                            <p class="text-gray-600 text-sm mb-3 line-clamp-2">
                                    ${club.intro}
                            </p>

                            <div class="flex items-center text-gray-500 text-sm mb-4">
                                <span class="flex items-center mr-4">
                                    <i class="fa fa-user-circle mr-1"></i> 创建人ID: ${club.founderId}
                                </span>
                            </div>

                            <button onclick="showApplyForm(${club.id}, '${club.name}')"
                                    class="w-full py-2 bg-primary hover:bg-primary/90 text-white rounded-lg transition-colors">
                                申请加入
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- 申请理由表单 -->
            <div id="applyForm" class="bg-white rounded-xl p-6 card-shadow hidden">
                <h3 class="text-xl font-bold text-gray-800 mb-4">
                    申请加入：<span id="currentClubName" class="text-primary"></span>
                </h3>

                <form action="${pageContext.request.contextPath}/club/apply/submit" method="post">
                    <input type="hidden" id="clubId" name="clubId" value="">

                    <div class="mb-6">
                        <label for="reason" class="block text-gray-700 font-medium mb-2">申请理由</label>
                        <textarea
                                id="reason"
                                name="reason"
                                rows="5"
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary resize-none"
                                placeholder="请说明你想加入该社团的原因、你的特长或能为社团做的贡献..."
                                required
                        ></textarea>
                    </div>

                    <div class="flex justify-end space-x-4">
                        <button type="button" onclick="hideApplyForm()"
                                class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors">
                            取消
                        </button>
                        <button type="submit"
                                class="px-6 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors">
                            <i class="fa fa-paper-plane mr-2"></i>提交申请
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</div>

<!-- 侧边栏切换与表单显示脚本 -->
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

    // 申请表单显示/隐藏逻辑
    function showApplyForm(clubId, clubName) {
        document.getElementById('clubId').value = clubId;
        document.getElementById('currentClubName').textContent = clubName;

        const form = document.getElementById('applyForm');
        form.classList.remove('hidden');
        form.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function hideApplyForm() {
        document.getElementById('applyForm').classList.add('hidden');
    }
</script>
</body>
</html>