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

export {getAllCategories, getCategoryDetails, getCategoriesByProjectId, getProjectsByCategoryId};