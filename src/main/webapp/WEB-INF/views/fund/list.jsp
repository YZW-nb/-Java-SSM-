<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>经费列表 - 社团管理系统</title>
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
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">经费列表</h2>
                <p class="text-gray-600">管理所有社团经费记录</p>
            </div>

            <!-- 筛选区域 -->
            <div id="filterArea" class="bg-white rounded-xl p-6 card-shadow mb-8 opacity-0 transition-opacity duration-500">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">筛选条件</h3>
                <form action="${pageContext.request.contextPath}/fund/list" method="get" class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <!-- 社团选择 -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">社团 <span class="text-red-500">*</span></label>
                        <select name="clubId" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                            <option value="">请选择社团</option>
                            <c:forEach items="${clubs}" var="club">
                                <option value="${club.id}">${club.name}</option>
                            </c:forEach>
                            <c:if test="${empty clubs}">
                                <option value="" disabled>没有可用的社团</option>
                            </c:if>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">开始时间</label>
                        <input type="date" name="startTime" value="${param.startTime}" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">结束时间</label>
                        <input type="date" name="endTime" value="${param.endTime}" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">类型</label>
                        <select name="type" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                            <option value="">所有类型</option>
                            <option value="1" <c:if test="${param.type != null && param.type == 1}">selected</c:if>>收入</option>
                            <option value="2" <c:if test="${param.type != null && param.type == 2}">selected</c:if>>支出</option>
                        </select>
                    </div>
                    <div class="md:col-span-4 flex justify-end space-x-3">
                        <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/fund/list'" class="px-4 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors">
                            重置
                        </button>
                        <button type="submit" class="px-4 py-2 bg-primary text-white rounded-lg text-sm font-medium hover:bg-primary/90 transition-colors">
                            <i class="fa fa-filter mr-1"></i> 筛选
                        </button>
                    </div>
                </form>
            </div>

            <!-- 操作按钮 -->
            <div class="flex justify-between items-center mb-6">
                <h3 class="text-xl font-bold text-gray-800">经费记录</h3>
                <a href="${pageContext.request.contextPath}/fund/add" class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm transition-colors flex items-center">
                    <i class="fa fa-plus mr-2"></i> 新增经费
                </a>
            </div>

            <!-- 错误提示 -->
            <c:if test="${not empty error}">
                <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6">
                    <i class="fa fa-exclamation-circle mr-2"></i>${error}
                </div>
            </c:if>

            <!-- 经费列表表格 -->
            <div class="bg-white rounded-xl card-shadow overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">社团</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">类型</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">金额</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">来源/用途</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">操作人</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">记录时间</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">凭证</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:if test="${empty funds}">
                            <tr>
                                <td colspan="9" class="px-6 py-10 text-center text-gray-500">
                                    <i class="fa fa-folder-open-o text-3xl mb-2"></i>
                                    <p>暂无经费记录</p>
                                </td>
                            </tr>
                        </c:if>
                        <!-- 限制显示数量，避免DOM节点过多 -->
                        <c:forEach items="${funds}" var="fund" begin="0" end="49">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${fund.id}</td>
                                <!-- 直接显示社团ID，不依赖关联对象 -->
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                    社团ID: ${fund.clubId}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${fund.type == 1 ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                ${fund.type == 1 ? '收入' : '支出'}
                                        </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium ${fund.type == 1 ? 'text-green-600' : 'text-red-600'}">
                                        ${fund.type == 1 ? '+' : '-'}¥<fmt:formatNumber value="${fund.amount}" pattern="#,##0.00" />
                                </td>
                                <td class="px-6 py-4 text-sm text-gray-500">${fund.sourceOrPurpose}</td>
                                <!-- 直接显示操作人ID，不依赖关联对象 -->
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    操作人ID: ${fund.operatorId}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <fmt:formatDate value="${fund.createTime}" pattern="yyyy-MM-dd HH:mm" />
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <c:if test="${not empty fund.proofDesc}">
                                            <span class="text-green-600 flex items-center">
                                                <i class="fa fa-check-circle mr-1"></i>已上传
                                            </span>
                                    </c:if>
                                    <c:if test="${empty fund.proofDesc}">
                                            <span class="text-red-600 flex items-center">
                                                <i class="fa fa-exclamation-circle mr-1"></i>未上传
                                            </span>
                                    </c:if>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <a href="${pageContext.request.contextPath}/fund/detail/${fund.id}" class="text-primary hover:text-primary/80 mr-3">
                                        <i class="fa fa-eye mr-1"></i>查看
                                    </a>
                                    <c:if test="${fund.type == 2}">
                                        <a href="${pageContext.request.contextPath}/fund/update/amount/${fund.id}" class="text-accent hover:text-accent/80 mr-3">
                                            <i class="fa fa-pencil mr-1"></i>修改金额
                                        </a>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/fund/delete/${fund.id}" class="text-red-500 hover:text-red-700" onclick="return confirm('确定要删除这条经费记录吗？删除后不可恢复！')">
                                        <i class="fa fa-trash mr-1"></i>删除
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- 简化后的分页控件 -->
                <div class="px-6 py-4 border-t border-gray-200 flex justify-center">
                    <a href="${pageContext.request.contextPath}/fund/list?pageNum=${pageNum > 1 ? pageNum-1 : 1}${param.clubId != null ? '&clubId=' + param.clubId : ''}${param.startTime != null ? '&startTime=' + param.startTime : ''}${param.endTime != null ? '&endTime=' + param.endTime : ''}${param.type != null ? '&type=' + param.type : ''}"
                       class="px-3 py-1 border rounded mr-2 ${pageNum == 1 ? 'opacity-50 cursor-not-allowed' : ''}">
                        上一页
                    </a>
                    <span class="px-3 py-1">第 ${pageNum} / ${totalPages} 页</span>
                    <a href="${pageContext.request.contextPath}/fund/list?pageNum=${pageNum < totalPages ? pageNum+1 : totalPages}${param.clubId != null ? '&clubId=' + param.clubId : ''}${param.startTime != null ? '&startTime=' + param.startTime : ''}${param.endTime != null ? '&endTime=' + param.endTime : ''}${param.type != null ? '&type=' + param.type : ''}"
                       class="px-3 py-1 border rounded ml-2 ${pageNum == totalPages ? 'opacity-50 cursor-not-allowed' : ''}">
                        下一页
                    </a>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    // 侧边栏切换
    const toggleSidebar = document.getElementById('toggle-sidebar');
    const mobileMenuButton = document.getElementById('mobile-menu-button');
    const sidebar = document.getElementById('sidebar');

    function toggleSidebarVisibility() {
        if (sidebar.classList.contains('-translate-x-full')) {
            sidebar.classList.remove('-translate-x-full');
        } else {
            sidebar.classList.add('-translate-x-full');
        }
    }

    if (toggleSidebar) {
        toggleSidebar.addEventListener('click', toggleSidebarVisibility);
    }

    if (mobileMenuButton) {
        mobileMenuButton.addEventListener('click', toggleSidebarVisibility);
    }

    // 处理窗口大小变化
    function handleResize() {
        if (window.innerWidth >= 1024) {
            sidebar.classList.remove('-translate-x-full');
        } else {
            sidebar.classList.add('-translate-x-full');
        }
    }

    window.addEventListener('resize', handleResize);
    handleResize(); // 初始调用一次

    // 延迟加载筛选区域，提高首屏渲染速度
    window.addEventListener('load', function() {
        setTimeout(() => {
            document.getElementById('filterArea').classList.add('opacity-100');
        }, 300);
    });
</script>
</body>
</html>