import db from './db.js'

const getAllProjects = async() => {
    const query = `
        SELECT project_id, title, description, location, date
      FROM public.projects;
    `;

    const result = await db.query(query);

    return result.rows;
}

const getProjectsByOrganizationId = async (organizationId) => {
      const query = `
        SELECT
          project_id,
          organization_id,
          title,
          description,
          location,
          date
        FROM projects
        WHERE organization_id = $1
        ORDER BY date;
      `;
      
      const queryParams = [organizationId];
      const result = await db.query(query, queryParams);

      return result.rows;
};

const getUpcomingProjects = async (number_of_projects) => {

    const query = `
        SELECT
            projects.project_id,
            projects.title,
            projects.description,
            projects.date,
            projects.location,
            projects.organization_id,
            organization.org_name AS organization_name

        FROM projects

        INNER JOIN organization
        ON projects.organization_id = organization.organization_id

        WHERE projects.date >= CURRENT_DATE

        ORDER BY projects.date ASC

        LIMIT $1;
    `;

    const queryParams = [number_of_projects];
    const result = await db.query(query, queryParams);

    return result.rows;
};

const getProjectDetails = async (id) => {

    const query = `
        SELECT
            projects.project_id,
            projects.title,
            projects.description,
            projects.date,
            projects.location,
            projects.organization_id,
            organization.org_name AS organization_name

        FROM projects

        INNER JOIN organization
        ON projects.organization_id = organization.organization_id

        WHERE projects.project_id = $1;
    `;

    const queryParams = [id];
    const result = await db.query(query, queryParams);

    return result.rows[0] || null;
};

export { getAllProjects, getProjectsByOrganizationId, getUpcomingProjects,  getProjectDetails };