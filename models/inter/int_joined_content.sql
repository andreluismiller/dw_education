with disciplines as (
    select * from {{ ref('stg_client__disciplines') }}
),
grades as (
    select * from {{ ref('stg_client__grades') }}
),
components as (
    select * from {{ ref('stg_client__discipline_types') }}
),
themes as (
    select * from {{ ref('stg_client__themes') }}
),
subjects as (
    select * from {{ ref('stg_client__subjects') }}
),
joined_content as (
    select
        subjects.subject_id,
        subjects.subject_external_id,
        subjects.subject,

        themes.theme_id,
        themes.theme_external_id,
        themes.theme,

        disciplines.discipline_id,
        disciplines.discipline_external_id,
        disciplines.discipline_color,
        disciplines.grade_group_code,

        components.discipline_type_id,
        components.discipline_type_code,

        grades.grade_id,
        grades.grade_code


    from subjects 
    inner join themes on subjects.theme_id = themes.theme_id
    inner join disciplines on themes.discipline_id = disciplines.discipline_id 
    inner join components on disciplines.discipline_type_id = components.discipline_type_id
    inner join grades on disciplines.grade_id = grades.grade_id
)
select * from joined_content