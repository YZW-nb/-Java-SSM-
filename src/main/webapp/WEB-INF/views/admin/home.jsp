<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员主页 - 社团管理系统</title>
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
                <a href="${pageContext.request.contextPath}/admin/home" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
                    <i class="fa fa-home w-5 text-center"></i>
                    <span>首页</span>
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">管理员首页</h2>
                <p class="text-gray-600">欢迎回来，李四！这是你的管理中心</p>
            </div>

            <!-- 数据概览卡片 -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">社团总数</h3>
                        <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center">
                            <i class="fa fa-university text-primary"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">42</span>
                        <span class="text-green-500 text-sm flex items-center">
                            <i class="fa fa-arrow-up mr-1"></i> 5%
                        </span>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">待审核社团</h3>
                        <div class="w-10 h-10 rounded-full bg-yellow-100 flex items-center justify-center">
                            <i class="fa fa-clock-o text-yellow-500"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">3</span>
                        <span class="text-red-500 text-sm flex items-center">
                            <i class="fa fa-arrow-up mr-1"></i> 100%
                        </span>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">活动总数</h3>
                        <div class="w-10 h-10 rounded-full bg-green-100 flex items-center justify-center">
                            <i class="fa fa-calendar text-secondary"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">128</span>
                        <span class="text-green-500 text-sm flex items-center">
                            <i class="fa fa-arrow-up mr-1"></i> 18%
                        </span>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-gray-600 font-medium">待审批经费</h3>
                        <div class="w-10 h-10 rounded-full bg-purple-100 flex items-center justify-center">
                            <i class="fa fa-credit-card text-accent"></i>
                        </div>
                    </div>
                    <div class="flex items-end justify-between">
                        <span class="text-3xl font-bold text-gray-800">5</span>
                        <span class="text-red-500 text-sm flex items-center">
                            <i class="fa fa-arrow-up mr-1"></i> 25%
                        </span>
                    </div>
                </div>
            </div>

            <!-- 最近活动审批 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">最近活动审批</h3>
                    <a href="#" class="text-primary hover:text-primary/80 flex items-center text-sm">
                        查看全部 <i class="fa fa-angle-right ml-1"></i>
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">活动名称</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">社团名称</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">申请时间</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">状态</th>
                            <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">校园科技文化节</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">科技协会</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-500">2025-07-20</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    待审批
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button class="text-primary hover:text-primary/80 mr-3">查看</button>
                                <button class="text-green-600 hover:text-green-800 mr-3">通过</button>
                                <button class="text-red-500 hover:text-red-800">拒绝</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">校园歌手大赛</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">音乐爱好者协会</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-500">2025-07-18</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                    已通过
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button class="text-primary hover:text-primary/80">查看</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">读书分享会</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">读书会</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-500">2025-07-15</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                    已通过
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button class="text-primary hover:text-primary/80">查看</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">篮球友谊赛</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">篮球社</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-500">2025-07-14</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                    已拒绝
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button class="text-primary hover:text-primary/80">查看</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 社团申请列表 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">社团申请列表</h3>
                    <a href="#" class="text-primary hover:text-primary/80 flex items-center text-sm">
                        查看全部 <i class="fa fa-angle-right ml-1"></i>
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">社团名称</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">创始人</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">申请时间</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">状态</th>
                            <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">人工智能社</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">王五</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-500">2025-07-22</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    待审批
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button class="text-primary hover:text-primary/80 mr-3">查看</button>
                                <button class="text-green-600 hover:text-green-800 mr-3">通过</button>
                                <button class="text-red-500 hover:text-red-800">拒绝</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">摄影协会</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">赵六</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-500">2025-07-21</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    待审批
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button class="text-primary hover:text-primary/80 mr-3">查看</button>
                                <button class="text-green-600 hover:text-green-800 mr-3">通过</button>
                                <button class="text-red-500 hover:text-red-800">拒绝</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">书法社</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">孙七</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-500">2025-07-20</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    待审批
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button class="text-primary hover:text-primary/80 mr-3">查看</button>
                                <button class="text-green-600 hover:text-green-800 mr-3">通过</button>
                                <button class="text-red-500 hover:text-red-800">拒绝</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 经费申请列表 -->
            <div class="bg-white rounded-xl p-6 card-shadow">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">经费申请列表</h3>
                    <a href="#" class="text-primary hover:text-primary/80 flex items-center text-sm">
                        查看全部 <i class="fa fa-angle-right ml-1"></i>
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">申请标题</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">社团名称</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">金额</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">申请时间</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">状态</th>
                            <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">科技文化节设备采购</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">科技协会</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">¥5,000.00</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-500">2025-07-21</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    待审批
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button class="text-primary hover:text-primary/80 mr-3">查看</button>
                                <button class="text-green-600 hover:text-green-800 mr-3">通过</button>
                                <button class="text-red-500 hover:text-red-800">拒绝</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">歌手大赛舞台布置</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">音乐爱好者协会</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">¥3,500.00</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-500">2025-07-19</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    待审批
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button class="text-primary hover:text-primary/80 mr-3">查看</button>
                                <button class="text-green-600 hover:text-green-800 mr-3">通过</button>
                                <button class="text-red-500 hover:text-red-800">拒绝</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
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