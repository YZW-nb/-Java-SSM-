<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑社团 - 社团管理系统</title>
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
                        danger: '#EF4444',
                    },
                    fontFamily: {
                        inter: ['Inter', 'system-ui', 'sans-serif'],
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
            .form-input-focus {
                @apply focus:ring-2 focus:ring-primary/50 focus:border-primary focus:outline-none;
            }
            .card-shadow {
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05), 0 4px 6px -2px rgba(0, 0, 0, 0.03);
            }
        }
    </style>
</head>
<body class="bg-gray-50 font-inter min-h-screen">
<!-- 导航栏 -->
<header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="container mx-auto px-4 py-3 flex justify-between items-center">
        <div class="flex items-center space-x-2">
            <i class="fa fa-shield text-primary text-2xl"></i>
            <h1 class="text-xl font-bold text-gray-800">社团管理系统</h1>
        </div>
        <div class="flex items-center space-x-6">
            <a href="/club/manage" class="text-gray-600 hover:text-primary transition-colors">
                <i class="fa fa-arrow-left mr-1"></i> 返回管理
            </a>
            <div class="relative">
                <img src="https://picsum.photos/id/${sessionScope.user.id}/40/40" alt="用户头像" class="w-8 h-8 rounded-full object-cover border-2 border-primary/20">
            </div>
        </div>
    </div>
</header>

<!-- 主内容区 -->
<main class="container mx-auto px-4 py-8 max-w-4xl">
    <div class="mb-8">
        <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800 flex items-center">
            <i class="fa fa-pencil-square-o text-primary mr-3"></i>
            编辑社团信息
        </h2>
        <p class="text-gray-500 mt-1">修改社团基本信息，完成后点击保存按钮提交更改</p>
    </div>

    <!-- 编辑表单卡片 -->
    <div class="bg-white rounded-xl p-6 md:p-8 card-shadow mb-6 transform transition-all hover:shadow-lg">
        <form id="editForm" action="/club/edit" method="post" class="space-y-6">
            <!-- 隐藏的ID字段 -->
            <input type="hidden" name="id" value="${club.id}">

            <!-- 社团名称 -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                <div class="md:col-span-3">
                    <label for="name" class="block text-sm font-medium text-gray-700 mb-1">
                        社团名称 <span class="text-danger">*</span>
                    </label>
                    <input type="text" id="name" name="name"
                           value="${club.name}"
                           class="w-full px-4 py-2.5 rounded-lg border border-gray-300 form-input-focus transition-all"
                           required
                           maxlength="50">
                    <p class="mt-1 text-xs text-gray-500">请输入不超过50个字符的社团名称</p>
                </div>
            </div>

            <!-- 社团类别与状态 -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label for="category" class="block text-sm font-medium text-gray-700 mb-1">
                        社团类别 <span class="text-danger">*</span>
                    </label>
                    <input type="text" id="category" name="category"
                           value="${club.category}"
                           class="w-full px-4 py-2.5 rounded-lg border border-gray-300 form-input-focus transition-all"
                           required
                           maxlength="20">
                    <p class="mt-1 text-xs text-gray-500">例如：学术、体育、文艺等</p>
                </div>

                <div>
                    <label for="status" class="block text-sm font-medium text-gray-700 mb-1">
                        社团状态 <span class="text-danger">*</span>
                    </label>
                    <select id="status" name="status"
                            class="w-full px-4 py-2.5 rounded-lg border border-gray-300 form-input-focus transition-all appearance-none bg-white"
                            required>
                        <option value="1" ${club.status == 1 ? 'selected' : ''}>正常运行</option>
                        <option value="0" ${club.status == 0 ? 'selected' : ''}>暂停活动</option>
                        <option value="2" ${club.status == 2 ? 'selected' : ''}>已解散</option>
                    </select>
                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                        <i class="fa fa-chevron-down text-xs"></i>
                    </div>
                </div>
            </div>

            <!-- 社团简介 -->
            <div>
                <label for="intro" class="block text-sm font-medium text-gray-700 mb-1">
                    社团简介 <span class="text-danger">*</span>
                </label>
                <textarea id="intro" name="intro" rows="5"
                          class="w-full px-4 py-2.5 rounded-lg border border-gray-300 form-input-focus transition-all resize-none"
                          required
                          maxlength="500">${club.intro}</textarea>
                <div class="flex justify-between mt-1">
                    <p class="text-xs text-gray-500">请简要介绍社团宗旨、活动内容等信息</p>
                    <span id="introCounter" class="text-xs text-gray-400">${club.intro.length()} / 500</span>
                </div>
            </div>

            <!-- 封面图片 -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">
                    社团封面
                </label>
                <div class="grid grid-cols-1 md:grid-cols-5 gap-4 items-center">
                    <div class="md:col-span-1">
                        <div class="relative border-2 border-dashed border-gray-300 rounded-lg p-1 hover:border-primary transition-colors">
                            <img id="coverPreview"
                                 src="${club.coverUrl != null ? club.coverUrl : 'https://picsum.photos/id/237/300/200'}"
                                 alt="社团封面"
                                 class="w-full h-24 object-cover rounded">
                            <input type="hidden" name="coverUrl" id="coverUrl" value="${club.coverUrl}">
                        </div>
                    </div>
                    <div class="md:col-span-4">
                        <button type="button" id="uploadBtn" class="px-4 py-2.5 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-colors mr-3">
                            <i class="fa fa-upload mr-1"></i> 上传新封面
                        </button>
                        <p class="mt-2 text-xs text-gray-500">建议尺寸：600×400px，支持JPG、PNG格式</p>
                    </div>
                </div>
            </div>

            <!-- 创建时间信息 -->
            <div class="pt-2 border-t border-gray-100">
                <p class="text-sm text-gray-500">
                    <i class="fa fa-clock-o mr-1"></i>
                    创建时间：${club.createTime != null ? club.createTime : '未知'}
                </p>
            </div>

            <!-- 操作按钮 -->
            <div class="flex justify-end space-x-3 pt-4 border-t border-gray-100">
                <button type="button" id="resetBtn" class="px-6 py-2.5 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors">
                    重置
                </button>
                <button type="submit" class="px-6 py-2.5 bg-primary text-white rounded-lg hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all shadow-sm hover:shadow">
                    <i class="fa fa-save mr-1"></i> 保存修改
                </button>
            </div>
        </form>
    </div>

    <!-- 提示卡片 -->
    <div class="bg-blue-50 border-l-4 border-primary p-4 rounded-r-lg">
        <div class="flex">
            <div class="flex-shrink-0">
                <i class="fa fa-info-circle text-primary"></i>
            </div>
            <div class="ml-3">
                <p class="text-sm text-blue-700">
                    编辑完成后将自动更新社团信息，所有成员均可查看最新内容
                </p>
            </div>
        </div>
    </div>
</main>

<!-- 页脚 -->
<footer class="bg-white border-t mt-12 py-6">
    <div class="container mx-auto px-4 text-center text-gray-500 text-sm">
        <p>© 2023 社团管理系统 - 版权所有</p>
    </div>
</footer>

<!-- 成功提示弹窗 -->
<div id="successToast" class="fixed top-4 right-4 bg-green-500 text-white px-6 py-3 rounded-lg shadow-lg transform translate-x-full transition-transform duration-300 flex items-center z-50">
    <i class="fa fa-check-circle mr-2"></i>
    <span>保存成功！</span>
</div>

<script>
    // 文本框字符计数
    const introTextarea = document.getElementById('intro');
    const introCounter = document.getElementById('introCounter');

    introTextarea.addEventListener('input', function() {
        const length = this.value.length;
        introCounter.textContent = `${length} / 500`;

        // 超过限制时高亮提示
        if (length > 500) {
            introCounter.classList.add('text-danger');
            this.classList.add('border-danger');
        } else {
            introCounter.classList.remove('text-danger');
            this.classList.remove('border-danger');
        }
    });

    // 重置按钮功能
    document.getElementById('resetBtn').addEventListener('click', function() {
        if (confirm('确定要重置表单吗？所有修改将被放弃')) {
            document.getElementById('editForm').reset();
            // 重置计数器
            introCounter.textContent = `${introTextarea.value.length} / 500`;
        }
    });

    // 表单提交处理
    document.getElementById('editForm').addEventListener('submit', function(e) {
        // 简单验证
        if (introTextarea.value.length > 500) {
            e.preventDefault();
            alert('社团简介不能超过500个字符');
            introTextarea.focus();
            return false;
        }

        // 模拟提交成功提示（实际项目中可根据后端返回结果显示）
        setTimeout(() => {
            const toast = document.getElementById('successToast');
            toast.classList.remove('translate-x-full');

            // 3秒后隐藏提示
            setTimeout(() => {
                toast.classList.add('translate-x-full');
            }, 3000);
        }, 500);
    });

    // 封面上传按钮（模拟）
    document.getElementById('uploadBtn').addEventListener('click', function() {
        // 实际项目中这里应该触发文件选择对话框
        // 这里用随机图片模拟上传效果
        const randomId = Math.floor(Math.random() * 100);
        const newUrl = `https://picsum.photos/id/${randomId}/300/200`;

        document.getElementById('coverPreview').src = newUrl;
        document.getElementById('coverUrl').value = newUrl;

        // 显示提示
        alert('图片上传成功（模拟）');
    });
</script>
</body>
</html>