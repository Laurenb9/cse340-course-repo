import db from './db.js'

const getAllCategories = async() => {
    const query = `
        SELECT category_id, category_name
        FROM public.categories;
    `;

    const result = await db.query(query);

    return result.rows;
};

const getCategoryDetails = async (id) => {

    const query = `
        SELECT
            category_id,
            category_name
        FROM categories
        WHERE category_id = $1;
    `;

    const queryParams = [id];
    const result = await db.query(query, queryParams);

    return result.rows[0] || null;
};

const getCategoriesByProjectId = async (project_id) => {

    const query = `
        SELECT
            categories.category_id,
            categories.category_name

        FROM categories

        INNER JOIN service_project_categories
        ON categories.category_id = service_project_categories.category_id

        WHERE service_project_categories.project_id = $1;
    `;

    const queryParams = [project_id];
    const result = await db.query(query, queryParams);

    return result.rows;
};

const getProjectsByCategoryId = async (category_id) => {

    const query = `
        SELECT
            projects.project_id,
            projects.title,
            projects.description,
            projects.date,
            projects.location,
            projects.organization_id

        FROM projects

        INNER JOIN service_project_categories
        ON projects.project_id = service_project_categories.project_id

        WHERE service_project_categories.category_id = $1;
    `;

    const queryParams = [category_id];
    const result = await db.query(query, queryParams);

    return result.rows;
};

const assignCategoryToProject = async(categoryId, projectId) => {
    const query = `
        INSERT INTO service_project_categories (category_id, project_id)
        VALUES ($1, $2);
    `;

    await db.query(query, [categoryId, projectId]);
}

const updateCategoryAssignments = async(projectId, categoryIds) => {
    // First, remove existing category assignments for the project
    const deleteQuery = `
        DELETE FROM service_project_categories
        WHERE project_id = $1;
    `;
    await db.query(deleteQuery, [projectId]);

    // Next, add the new category assignments
    for (const categoryId of categoryIds) {
        await assignCategoryToProject(categoryId, projectId);
    }
}

const createCategory = async (categoryName) => {
    const query = `
        INSERT INTO categories (category_name)
        VALUES ($1)
        RETURNING category_id;
    `;

    const queryParams = [categoryName];
    const result = await db.query(query, queryParams);

    if (result.rows.length === 0) {
        throw new Error('Failed to create category');
    }

    return result.rows[0].category_id;
};

const updateCategory = async (categoryId, categoryName) => {
    const query = `
    UPDATE categories
    SET category_name = $1
    WHERE category_id = $2
    RETURNING category_id;
    `;

    const queryParams = [categoryName, categoryId];
    const result = await db.query(query, queryParams);

    if(result.rows.length === 0){
        throw new Error('category not found');
    }

    return result.rows[0].category_id;
};

export {
    getAllCategories, 
    getCategoryDetails, 
    getCategoriesByProjectId, 
    getProjectsByCategoryId,
    updateCategoryAssignments,
    createCategory,
    updateCategory
};