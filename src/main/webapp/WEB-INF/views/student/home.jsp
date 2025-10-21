<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生主页 - 社团管理系统</title>
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
                <a href="${pageContext.request.contextPath}/student/home" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
                    <i class="fa fa-home w-5 text-center"></i>
                    <span>首页</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/member/my"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">学生首页</h2>
                <p class="text-gray-600">欢迎回来，张三！这是你的个人中心</p>
            </div>

            <!-- 数据概览卡片 -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">我的社团</h3>
                        <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center">
                            <i class="fa fa-university text-primary"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">3</span>
                        <span class="text-green-500 text-sm flex items-center">
                                <i class="fa fa-arrow-up mr-1"></i> 12%
                            </span>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">参与活动</h3>
                        <div class="w-10 h-10 rounded-full bg-green-100 flex items-center justify-center">
                            <i class="fa fa-calendar text-secondary"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">5</span>
                        <span class="text-green-500 text-sm flex items-center">
                                <i class="fa fa-arrow-up mr-1"></i> 8%
                            </span>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">经费申请</h3>
                        <div class="w-10 h-10 rounded-full bg-purple-100 flex items-center justify-center">
                            <i class="fa fa-credit-card text-accent"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">2</span>
                        <span class="text-red-500 text-sm flex items-center">
                                <i class="fa fa-arrow-down mr-1"></i> 5%
                            </span>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">待办事项</h3>
                        <div class="w-10 h-10 rounded-full bg-red-100 flex items-center justify-center">
                            <i class="fa fa-tasks text-red-500"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">1</span>
                        <span class="text-green-500 text-sm flex items-center">
                                <i class="fa fa-arrow-down mr-1"></i> 33%
                            </span>
                    </div>
                </div>
            </div>

            <!-- 最近活动 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">最近活动</h3>
                    <a href="#" class="text-primary hover:text-primary/80 flex items-center text-sm">
                        查看全部 <i class="fa fa-angle-right ml-1"></i>
                    </a>
                </div>

                <div class="space-y-4">
                    <div class="flex items-start p-4 rounded-lg hover:bg-gray-50 transition-colors">
                        <div class="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center mr-4 flex-shrink-0">
                            <i class="fa fa-calendar text-primary text-xl"></i>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between">
                                <h4 class="font-medium text-gray-800">校园科技文化节</h4>
                                <span class="text-xs px-2 py-1 bg-green-100 text-green-800 rounded-full">进行中</span>
                            </div>
                            <p class="text-gray-600 text-sm mt-1">科技协会</p>
                            <div class="flex items-center text-gray-500 text-sm mt-2">
                                    <span class="flex items-center mr-4">
                                        <i class="fa fa-clock-o mr-1"></i> 2025-07-25
                                    </span>
                                <span class="flex items-center">
                                        <i class="fa fa-map-marker mr-1"></i> 体育馆
                                    </span>
                            </div>
                        </div>
                        <button class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                            报名参加
                        </button>
                    </div>

                    <div class="flex items-start p-4 rounded-lg hover:bg-gray-50 transition-colors">
                        <div class="w-12 h-12 rounded-lg bg-secondary/10 flex items-center justify-center mr-4 flex-shrink-0">
                            <i class="fa fa-music text-secondary text-xl"></i>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between">
                                <h4 class="font-medium text-gray-800">校园歌手大赛</h4>
                                <span class="text-xs px-2 py-1 bg-blue-100 text-blue-800 rounded-full">即将开始</span>
                            </div>
                            <p class="text-gray-600 text-sm mt-1">音乐爱好者协会</p>
                            <div class="flex items-center text-gray-500 text-sm mt-2">
                                    <span class="flex items-center mr-4">
                                        <i class="fa fa-clock-o mr-1"></i> 2025-07-30
                                    </span>
                                <span class="flex items-center">
                                        <i class="fa fa-map-marker mr-1"></i> 音乐厅
                                    </span>
                            </div>
                        </div>
                        <button class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                            报名参加
                        </button>
                    </div>

                    <div class="flex items-start p-4 rounded-lg hover:bg-gray-50 transition-colors">
                        <div class="w-12 h-12 rounded-lg bg-accent/10 flex items-center justify-center mr-4 flex-shrink-0">
                            <i class="fa fa-book text-accent text-xl"></i>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between">
                                <h4 class="font-medium text-gray-800">读书分享会</h4>
                                <span class="text-xs px-2 py-1 bg-gray-100 text-gray-800 rounded-full">已结束</span>
                            </div>
                            <p class="text-gray-600 text-sm mt-1">读书会</p>
                            <div class="flex items-center text-gray-500 text-sm mt-2">
                                    <span class="flex items-center mr-4">
                                        <i class="fa fa-clock-o mr-1"></i> 2025-07-20
                                    </span>
                                <span class="flex items-center">
                                        <i class="fa fa-map-marker mr-1"></i> 图书馆会议室
                                    </span>
                            </div>
                        </div>
                        <button class="bg-gray-200 text-gray-600 px-4 py-2 rounded-lg text-sm cursor-not-allowed">
                            已结束
                        </button>
                    </div>
                </div>
            </div>

            <!-- 我的社团 -->
            <div class="bg-white rounded-xl p-6 card-shadow">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">我的社团</h3>
                    <a href="${pageContext.request.contextPath}/club/member/my" class="text-primary hover:text-primary/80 flex items-center text-sm">
                        查看全部 <i class="fa fa-angle-right ml-1"></i>
                    </a>

                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div class="border border-gray-200 rounded-xl overflow-hidden hover:shadow-md transition-shadow">
                        <div class="h-36 bg-primary/10 relative">
                            <img src="https://picsum.photos/id/28/600/400" alt="科技协会" class="w-full h-full object-cover">
                            <div class="absolute top-3 right-3 bg-white rounded-full px-3 py-1 text-xs font-medium text-primary">
                                会长
                            </div>
                        </div>
                        <div class="p-4">
                            <h4 class="font-bold text-gray-800">科技协会</h4>
                            <p class="text-gray-600 text-sm mt-1">探索前沿科技，分享创新理念</p>
                            <div class="flex items-center mt-3 text-gray-500 text-sm">
                                    <span class="flex items-center mr-4">
                                        <i class="fa fa-users mr-1"></i> 128 成员
                                    </span>
                                <span class="flex items-center">
                                        <i class="fa fa-calendar mr-1"></i> 成立于 2020-09-01
                                    </span>
                            </div>
                            <div class="flex items-center justify-between mt-4">
                                <button class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                                    管理
                                </button>
                                <button class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-4 py-2 rounded-lg text-sm transition-colors">
                                    退出
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="border border-gray-200 rounded-xl overflow-hidden hover:shadow-md transition-shadow">
                        <div class="h-36 bg-secondary/10 relative">
                            <img src="https://picsum.photos/id/36/600/400" alt="音乐爱好者协会" class="w-full h-full object-cover">
                            <div class="absolute top-3 right-3 bg-white rounded-full px-3 py-1 text-xs font-medium text-green-600">
                                成员
                            </div>
                        </div>
                        <div class="p-4">
                            <h4 class="font-bold text-gray-800">音乐爱好者协会</h4>
                            <p class="text-gray-600 text-sm mt-1">用音乐传递情感，用歌声连接心灵</p>
                            <div class="flex items-center mt-3 text-gray-500 text-sm">
                                    <span class="flex items-center mr-4">
                                        <i class="fa fa-users mr-1"></i> 86 成员
                                    </span>
                                <span class="flex items-center">
                                        <i class="fa fa-calendar mr-1"></i> 成立于 2019-11-15
                                    </span>
                            </div>
                            <div class="flex items-center justify-between mt-4">
                                <button class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                                    查看
                                </button>
                                <button class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-4 py-2 rounded-lg text-sm transition-colors">
                                    退出
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="border border-gray-200 rounded-xl overflow-hidden hover:shadow-md transition-shadow">
                        <div class="h-36 bg-accent/10 relative">
                            <img src="https://picsum.photos/id/160/600/400" alt="读书会" class="w-full h-full object-cover">
                            <div class="absolute top-3 right-3 bg-white rounded-full px-3 py-1 text-xs font-medium text-purple-600">
                                成员
                            </div>
                        </div>
                        <div class="p-4">
                            <h4 class="font-bold text-gray-800">读书会</h4>
                            <p class="text-gray-600 text-sm mt-1">读万卷书，行万里路</p>
                            <div class="flex items-center mt-3 text-gray-500 text-sm">
                                    <span class="flex items-center mr-4">
                                        <i class="fa fa-users mr-1"></i> 64 成员
                                    </span>
                                <span class="flex items-center">
                                        <i class="fa fa-calendar mr-1"></i> 成立于 2021-03-20
                                    </span>
                            </div>
                            <div class="flex items-center justify-between mt-4">
                                <button class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                                    查看
                                </button>
                                <button class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-4 py-2 rounded-lg text-sm transition-colors">
                                    退出
                                </button>
                            </div>
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
</script>
</body>
</html>