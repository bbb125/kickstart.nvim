return {
  {
    'letieu/jira.nvim',
    opts = {
      jira = {
        base = 'https://tsimagine.atlassian.net',
        email = 'vladimir.bayda@tsimagine.com',
        type = 'basic',
        limit = 200,
      },
      queries = {
        ['PBS Queue'] = 'project = PBS AND Status = "With Development" AND "DevTeam[Dropdown]" = RISK_CORE ORDER BY priority DESC',
      },
    },
  },
}
