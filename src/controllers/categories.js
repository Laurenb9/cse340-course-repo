import {
    getAllCategories,
    getCategoryDetails,
    getCategoriesByProjectId,
    getProjectsByCategoryId,
    updateCategoryAssignments,
    createCategory,
    updateCategory
} from '../models/categories.js';

import { getProjectDetails } from '../models/projects.js';

const showCategoriesPage = async (req, res) => {
    const categories = await getAllCategories();
    const title = 'Service Categories';

    res.render('categories', { title, categories });

};

const showNewCategoryForm = async (req, res) => {
    const title = 'Create New Category';

    res.render('new-category', { title });
};

const processNewCategoryForm = async (req, res) => {
    const categoryName = req.body.categoryName?.trim();

    if (!categoryName || categoryName.length < 3 || categoryName.length > 100) {
        req.flash('error', 'Category name must be between 3 and 100 characters.');
        return res.redirect('/new-category');
    }

    await createCategory(categoryName);

    req.flash('success', 'Category created successfully.');
    res.redirect('/categories');
};

const processEditCategoryForm = async (req, res) => {
    const categoryId = req.params.id;
    const categoryName = req.body.categoryName?.trim();

    if (!categoryName || categoryName.length < 3 || categoryName.length > 100) {
        req.flash('error', 'Category name must be between 3 and 100 characters.');
        return res.redirect(`/edit-category/${categoryId}`);
    }

    await updateCategory(categoryId, categoryName);

    req.flash('success', 'Category updated successfully.');
    res.redirect(`/category/${categoryId}`);
};

const showEditCategoryForm = async (req, res) => {
    const categoryId = req.params.id;
    const category = await getCategoryDetails(categoryId);

    if (!category) {
        req.flash('error', 'Category not found.');
        return res.redirect('/categories');
    }

    const title = 'Edit Category';

    res.render('edit-category', { title, category });
};

const showCategoryDetailsPage = async (req, res) => {
    const categoryId = req.params.id;
    const category = await getCategoryDetails(categoryId);
    const projects = await getProjectsByCategoryId(categoryId);
    const title = 'Category Details';

    res.render('category', { title, category, projects });

};

const showAssignCategoriesForm = async (req, res) => {
    const projectId = req.params.projectId;

    const projectDetails = await getProjectDetails(projectId);
    const categories = await getAllCategories();
    const assignedCategories = await getCategoriesByProjectId(projectId);

    const title = 'Assign Categories to Project';

    res.render('assign-categories', { title, projectId, projectDetails, categories, assignedCategories });
};

const processAssignCategoriesForm = async (req, res) => {
    const projectId = req.params.projectId;
    const selectedCategoryIds = req.body.categoryIds || [];
    
    // Ensure selectedCategoryIds is an array
    const categoryIdsArray = Array.isArray(selectedCategoryIds) ? selectedCategoryIds : [selectedCategoryIds];
    await updateCategoryAssignments(projectId, categoryIdsArray);
    req.flash('success', 'Categories updated successfully.');
    res.redirect(`/project/${projectId}`);
};

export { 
    showCategoriesPage, 
    showCategoryDetailsPage,
    showAssignCategoriesForm,
    processAssignCategoriesForm,
    showNewCategoryForm,
    showEditCategoryForm,
    processNewCategoryForm,
    processEditCategoryForm
 };